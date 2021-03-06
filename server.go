package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"strconv"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/cors"
	"github.com/jinzhu/configor"
	"github.com/unrolled/render"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

var format = render.New()

// Response describes a general response
type Response struct {
	Invalid bool   `json:"invalid"`
	Error   string `json:"error"`
	ID      string `json:"id"`
}

// EventInfo describes data fields
type EventInfo struct {
	ID            int    `json:"id"`
	Text          string `json:"text"`
	StartDate     string `db:"start_date" json:"start_date"`
	EndDate       string `db:"end_date" json:"end_date"`
	Color         string `json:"color"`
	Calendar      int    `json:"calendar"`
	Details       string `json:"details"`
	AllDay        int    `db:"all_day" json:"all_day"`
	Recurring     string `json:"recurring"`
	OriginID      int    `db:"origin_id" json:"origin_id"`
	SeriesEndDate string `db:"series_end_date" json:"series_end_date"`
	Units         string `json:"units"`
	Section       int    `json:"section"`
}

// CalendarInfo describes calendar data fields
type CalendarInfo struct {
	ID     int    `json:"id"`
	Text   string `json:"text"`
	Color  string `json:"color"`
	Active int    `json:"active"`
}

// UnitInfo descriebs unit data fields
type UnitInfo struct {
	ID     int     `json:"id"`
	Value  string  `json:"value"`
}

//SectionInfo describes data fields for sections (used by timeline view)
type SectionInfo struct {
	ID   int    `json:"id"`
	Text string `json:"text"`
}

//
var conn *sqlx.DB

// AppConfig describes application configuration
type AppConfig struct {
	Port         string
	ResetOnStart bool

	DB DBConfig
}

// DBConfig describes database configuration
type DBConfig struct {
	Host     string `default:"localhost"`
	Port     string `default:"3306"`
	User     string `default:"root"`
	Password string `default:"1"`
	Database string `default:"calendar"`
}

// Config is a structure with settings of this app instance
var Config AppConfig

func main() {
	flag.StringVar(&Config.Port, "port", ":3000", "port for web server")
	flag.Parse()

	configor.New(&configor.Config{ENVPrefix: "APP", Silent: true}).Load(&Config, "config.yml")

	// common drive access
	var err error

	connStr := fmt.Sprintf("%s:%s@(%s:%s)/%s?multiStatements=true&parseTime=true",
		Config.DB.User, Config.DB.Password, Config.DB.Host, Config.DB.Port, Config.DB.Database)
	conn, err = sqlx.Connect("mysql", connStr)
	if err != nil {
		log.Fatal(err)
	}

	migration(conn)

	if err != nil {
		log.Fatal(err)
	}

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	cors := cors.New(cors.Options{
		AllowedOrigins:   []string{"*"},
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Accept", "Authorization", "Content-Type", "X-CSRF-Token"},
		AllowCredentials: true,
		MaxAge:           300,
	})
	r.Use(cors.Handler)

	r.Get("/events", func(w http.ResponseWriter, r *http.Request) {
		from := r.URL.Query().Get("from")
		to := r.URL.Query().Get("to")

		data := make([]EventInfo, 0)
		var qs string
		var err error

		if from != "" && to != "" {
			qs = "SELECT event.* FROM event WHERE start_date < ? AND (series_end_date >= ? OR recurring != '' AND series_end_date = '' OR end_date >= ?) ORDER BY start_date;"
			err = conn.Select(&data, qs, to, from, from)
			if err != nil {
				format.Text(w, 500, err.Error())
				return
			}
		} else {
			qs = "SELECT event.* FROM event ORDER BY start_date;"
			err = conn.Select(&data, qs)
			if err != nil {
				format.Text(w, 500, err.Error())
				return
			}
		}

		format.JSON(w, 200, data)
	})

	r.Put("/events/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")
		r.ParseForm()

		err = sendUpdateQuery("event", r.Form, id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		mode := r.Form.Get("recurring_update_mode")
		if mode == "all" {
			// remove all sub-events
			_, err := conn.Exec("DELETE FROM event WHERE origin_id = ?", id)
			if err != nil {
				format.Text(w, 500, err.Error())
				return
			}
		} else if mode == "next" {
			// remove all sub-events after new 'this and next' group
			date := r.Form.Get("recurring_update_date")
			if date == "" {
				panic("date must be provided")
			}

			// in case update came for a subevent, search the master event
			var oid int
			err = conn.Get(&oid, "SELECT origin_id FROM event WHERE id = ?", id)
			if err != nil {
				format.Text(w, 500, err.Error())
				return
			}
			if oid != 0 {
				id = strconv.Itoa(oid)
			}

			_, err = conn.Exec("DELETE FROM event WHERE origin_id = ? AND start_date >= ?", id, date)
			if err != nil {
				format.Text(w, 500, err.Error())
				return
			}
		}

		format.JSON(w, 200, Response{ID: id})
	})

	r.Delete("/events/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")

		_, err := conn.Exec("DELETE FROM event WHERE id = ? OR origin_id = ?", id, id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, Response{ID: id})
	})

	r.Post("/events", func(w http.ResponseWriter, r *http.Request) {
		r.ParseForm()

		res, err := sendInsertQuery("event", r.Form)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		id, _ := res.LastInsertId()
		format.JSON(w, 200, Response{ID: strconv.FormatInt(id, 10)})
	})

	r.Get("/calendars", func(w http.ResponseWriter, r *http.Request) {
		data := make([]CalendarInfo, 0)
		err := conn.Select(&data, "SELECT calendar.* FROM calendar")

		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, data)
	})

	r.Put("/calendars/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")
		r.ParseForm()

		err := sendUpdateQuery("calendar", r.Form, id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, Response{ID: id})
	})

	r.Delete("/calendars/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")

		_, err := conn.Exec("DELETE FROM calendar WHERE id = ?", id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}
		_, err = conn.Exec("DELETE FROM event WHERE calendar = ?", id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, Response{ID: id})
	})

	r.Post("/calendars", func(w http.ResponseWriter, r *http.Request) {
		r.ParseForm()

		res, err := sendInsertQuery("calendar", r.Form)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		id, _ := res.LastInsertId()
		format.JSON(w, 200, Response{ID: strconv.FormatInt(id, 10)})
	})

	r.Get("/units", func(w http.ResponseWriter, r *http.Request) {
		data := make([]UnitInfo, 0)
		err := conn.Select(&data, "SELECT unit.* FROM unit")

		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, data)
	})

	r.Get("/sections", func(w http.ResponseWriter, r *http.Request) {
		data := make([]SectionInfo, 0)
		err := conn.Select(&data, "SELECT section.* FROM section")

		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, data)
	})

	log.Printf("Starting webserver at port " + Config.Port)
	http.ListenAndServe(Config.Port, r)
}

// both event and calendar tables
var whitelistEvent = []string{
	"start_date",
	"end_date",
	"all_day",
	"text",
	"details",
	"color",
	"recurring",
	"calendar",
	"origin_id",
	"series_end_date",
	"units",
	"section",
}
var whitelistCalendar = []string{
	"text",
	"color",
	"active",
}

func getWhiteList(table string) []string {
	allowedFields := make([]string, 0, 10)
	if table == "event" {
		allowedFields = append(allowedFields, whitelistEvent...)
	} else {
		allowedFields = append(allowedFields, whitelistCalendar...)
	}
	return allowedFields
}

func sendUpdateQuery(table string, form url.Values, id string) error {
	qs := "UPDATE " + table + " SET "
	params := make([]interface{}, 0)

	allowedFields := getWhiteList(table)
	for _, key := range allowedFields {
		value, ok := form[key]
		if ok {
			qs += key + " = ?, "
			params = append(params, value[0])
		}
	}
	params = append(params, id)

	_, err := conn.Exec(qs[:len(qs)-2]+" WHERE id = ?", params...)
	return err
}

func sendInsertQuery(table string, form map[string][]string) (sql.Result, error) {
	qsk := "INSERT INTO " + table + " ("
	qsv := "VALUES ("
	params := make([]interface{}, 0)

	allowedFields := getWhiteList(table)
	for _, key := range allowedFields {
		value, ok := form[key]
		if ok {
			qsk += key + ", "
			qsv += "?, "
			params = append(params, value[0])
		}
	}

	qsk = qsk[:len(qsk)-2] + ") "
	qsv = qsv[:len(qsv)-2] + ")"

	res, err := conn.Exec(qsk+qsv, params...)
	return res, err
}
