package main

import (
	"database/sql"
	"fmt"
	"html/template"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB
var err error

func init() {
	// Open up our database connection.
	// I've set up a database on my local machine using phpmyadmin.
	// The database is called testDb
	db, err = sql.Open("mysql", "root:33133@tcp(127.0.0.1:3308)/hosting_db")

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	// defer the close till after the main function has finished
	// executing
	// defer db.Close()

	fmt.Println("DB Connection Successfully")
}

func main() {

	http.HandleFunc("/", home)
	http.HandleFunc("/request", request)
	http.HandleFunc("/features", features)
	http.HandleFunc("/docs", docs)
	http.Handle("/resources/", http.StripPrefix("/resources/", http.FileServer(http.Dir("assets"))))
	http.ListenAndServe(":8888", nil)
}

func home(w http.ResponseWriter, r *http.Request) {
	ptmp, err := template.ParseFiles("template/base.html")
	if err != nil {
		fmt.Println(err.Error())
	}

	ptmp.Execute(w, nil)
	//fmt.Fprintf(w, `Welcome to our first Golang Website`)
}

func features(w http.ResponseWriter, r *http.Request) {

	ptmp, err := template.ParseFiles("template/base.html")
	if err != nil {
		fmt.Println(err.Error())
	}

	ptmp, err = ptmp.ParseFiles("wpage/features.html")
	if err != nil {
		fmt.Println(err.Error())
	}
	ptmp.Execute(w, nil)
	//fmt.Fprintf(w, `Welcome to our first Golang Website`)
}

func docs(w http.ResponseWriter, r *http.Request) {

	ptmp, err := template.ParseFiles("template/base.html")
	if err != nil {
		fmt.Println(err.Error())
	}

	ptmp, err = ptmp.ParseFiles("wpage/docs.html")
	if err != nil {
		fmt.Println(err.Error())
	}

	ptmp.Execute(w, nil)
	//fmt.Fprintf(w, `Welcome to our first Golang Website`)
}

func request(w http.ResponseWriter, r *http.Request) {

	name := r.FormValue("name")
	company := r.FormValue("company")
	email := r.FormValue("email")

	// fmt.Println(name, company, email)

	// fmt.Fprintf(w, `received`)

	// r.ParseForm()

	// for key, val := range r.Form {
	// 	fmt.Println(key, val)
	// }

	// fmt.Fprintf(w, `OK`)

	qs := "INSERT INTO `request` (`name`,`company`,`email`,`status`)  VALUES ( '%s', '%s', '%s', 1 )"
	sql := fmt.Sprintf(qs, name, company, email)

	// perform a db.Query insert
	insert, err := db.Query(sql)

	// if there is an error inserting, handle it
	if err != nil {
		panic(err.Error())
	}
	// be careful deferring Queries if you are using transactions
	defer insert.Close()
}
