package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/cors"
	"github.com/jinzhu/configor"
	"github.com/unrolled/render"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

var format = render.New()

type EventInfo struct {
	ID        int    `json:"id"`
	Text      string `json:"text"`
	StartDate string `db:"start_date" json:"start_date"`
	EndDate   string `db:"end_date" json:"end_date"`
	Color     string `json:"color"`
	Calendar  int    `json:"calendar"`
	Detains   string `json:"details"`
	AllDay    int    `db:"all_day" json:"all_day"`
	Recurring string `json:"recurring"`
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

		var data []EventInfo
		var qs string

		if from != "" && to != "" {
			qs = "SELECT event.* FROM event WHERE start_date < ? AND end_date >= ? ORDER BY start_date;"

			// 	start_date:{$lt:to+" 24:00"},
			// 	end_date:{$gte:from}

		} else {
			qs = "SELECT event.* FROM event ORDER BY start_date;"
		}

		err := conn.Select(&data, qs, to, from)

		if err != nil {
			panic(err)
		}

		format.JSON(w, 200, data)
	})

	r.Put("/events/{id}", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Delete("/events/{id}", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Post("/events", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Get("/calendars", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Put("/calendars/{id}", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Delete("/calendars/{id}", func(w http.ResponseWriter, r *http.Request) {

	})

	r.Post("/calendars", func(w http.ResponseWriter, r *http.Request) {

	})

	log.Printf("Starting webserver at port " + Config.Port)
	http.ListenAndServe(Config.Port, r)
}
