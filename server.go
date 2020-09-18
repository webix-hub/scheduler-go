package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"net/http"
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

type Response struct {
	Invalid bool   `json:"invalid"`
	Error   string `json:"error"`
	ID      string `json:"id"`
}

type EventInfo struct {
	ID        int    `json:"id"`
	Text      string `json:"text"`
	StartDate string `db:"start_date" json:"start_date"`
	EndDate   string `db:"end_date" json:"end_date"`
	Color     string `json:"color"`
	Calendar  int    `json:"calendar"`
	Details   string `json:"details"`
	AllDay    int    `db:"all_day" json:"all_day"`
	Recurring string `json:"recurring"`
}

type CalendarInfo struct {
	ID     int    `json:"id"`
	Text   string `json:"text"`
	Color  string `json:"color"`
	Active int    `json:"active"`
}

var conn *sqlx.DB

type AppConfig struct {
	Port         string
	ResetOnStart bool

	DB DBConfig
}

type DBConfig struct {
	Host     string `default:"localhost"`
	Port     string `default:"3306"`
	User     string `default:"root"`
	Password string `default:"1"`
	Database string `default:"calendar"`
}

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
			qs = "SELECT event.* FROM event WHERE start_date < ? AND end_date >= ? ORDER BY start_date;"
			err = conn.Select(&data, qs, to, from)
		} else {
			qs = "SELECT event.* FROM event ORDER BY start_date;"
			err = conn.Select(&data, qs)
		}

		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, data)
	})

	r.Put("/events/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")
		r.ParseForm()

		err := sendUpdateQuery("event", r.Form, id)
		if err != nil {
			format.Text(w, 500, err.Error())
			return
		}

		format.JSON(w, 200, Response{ID: id})
	})

	r.Delete("/events/{id}", func(w http.ResponseWriter, r *http.Request) {
		id := chi.URLParam(r, "id")

		_, err := conn.Exec("DELETE FROM event WHERE id = ?", id)
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
		err := conn.Select(&data, "SELECT calendar.* FROM calendar;")

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

	log.Printf("Starting webserver at port " + Config.Port)
	http.ListenAndServe(Config.Port, r)
}

func sendUpdateQuery(table string, form map[string][]string, id string) error {
	qs := "UPDATE " + table + " SET "
	params := make([]interface{}, 0)
	for key, values := range form {
		qs += key + " = ?, "
		params = append(params, values[0])
	}
	params = append(params, id)

	_, err := conn.Exec(qs[:len(qs)-2]+" WHERE id = ?", params...)
	return err
}

func sendInsertQuery(table string, form map[string][]string) (sql.Result, error) {
	qsk := "INSERT INTO " + table + " ("
	qsv := "VALUES ("
	params := make([]interface{}, 0)
	for key, values := range form {
		qsk += key + ", "
		qsv += "?, "
		params = append(params, values[0])
	}
	qsk = qsk[:len(qsk)-2] + ") "
	qsv = qsv[:len(qsv)-2] + ")"

	res, err := conn.Exec(qsk+qsv, params...)
	return res, err
}
