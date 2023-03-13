package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/url"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/mateors/msql"
)

var db *sql.DB
var err error

func init() {

	// Connect to database
	db, err = sql.Open("mysql", "root:@tcp(localhost:3308)/youthict?charset=utf8")
	if err != nil {
		panic(err)
	}
	// See "Important settings" section.
	db.SetConnMaxLifetime(time.Minute * 3)
	db.SetMaxOpenConns(10)
	db.SetMaxIdleConns(10)

	defer db.Close()
	log.Println("db connection successful")

}

func insert2() {

	m := make(url.Values)
	dt := time.Now().Format("2006-01-02 15:04:05")
	m.Set("name", "MATEORS DOT COM")
	m.Set("email", "billahmdmostain@gmail.com")
	m.Set("create_date", dt)

	m.Set("todo", "insert")
	m.Set("id", "1")       //
	m.Set("pkfield", "id") //
	m.Set("table", "company")
	msql.InsertUpdate(m, db)
}

func retrieve2() {

	rows, err := msql.GetAllRowsByQuery("select name,email,status from company;", db)
	if err != nil {
		log.Println(err)
	}

	for _, row := range rows {
		fmt.Println(row)
	}

}

func delete2() {
	_, err := db.Query("DELETE FROM company WHERE id=?", 1)
	if err != nil {
		log.Println(err)
	}
}

func main() {

	//insert into company
	insert2()

	//retrieve
	retrieve2()

	//delete
	delete2()

	var v Values
	fmt.Println(v)

}
