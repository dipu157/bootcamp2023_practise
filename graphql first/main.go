package main

import (
	"database/sql"
	"graphapi/database"
	"graphapi/object"
	"log"
	"net/http"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/graphql-go/graphql"
	"github.com/graphql-go/handler"
)

// var db *sql.DB
var err error

func init() {

	// Connect to database
	database.DB, err = sql.Open("mysql", "root:33133@tcp(localhost:3308)/youthict?charset=utf8")
	if err != nil {
		panic(err)
	}
	// See "Important settings" section.
	// db.SetConnMaxLifetime(time.Minute * 3)
	// db.SetMaxOpenConns(10)
	// db.SetMaxIdleConns(10)

	database.DB.SetConnMaxLifetime(time.Minute * 3)
	database.DB.SetMaxOpenConns(10)
	database.DB.SetMaxIdleConns(10)
	err = database.DB.Ping()
	if err != nil {
		log.Fatal("db ping error:", err)
	}

	//defer db.Close()
	log.Println("db connection successful")

}

func main() {

	var rootQueryType = graphql.NewObject(graphql.ObjectConfig{
		Name: "Query", //retrieve | select
		Fields: graphql.Fields{
			//http://localhost:8090/graphql?query={student(id:2,token:"232323"){id,name,email}}
			//"student": object.RetrieveStudentField(),

			//http://localhost:8090/graphql?query={listStudent{id,name,email}}
			//"listStudent": object.ListStudentField(),

			"company": object.CompanyById(),

			"listCompany": object.ListCompany(),
		},
	})

	var rootMutationType = graphql.NewObject(graphql.ObjectConfig{
		Name: "Mutation", //create,update,delete
		Fields: graphql.Fields{

			"createCompany": object.CreateCompanyField(),

			"updateCompany": object.UpdateCompanyField(),

			"deleteCompany": object.DeleteCompanyField(),

			// http://localhost:8080/graphql?query=mutation+_{createStudent(token:"ssd",name:"Domain",description:"domain purchase",status:1){id,name}}
			//"createStudent": object.CreateStudentField(),
		},
	})

	var schema, err = graphql.NewSchema(
		graphql.SchemaConfig{
			Query:    rootQueryType,
			Mutation: rootMutationType,
		},
	)
	if err != nil {
		log.Fatal("SCHEMA_ERROR:", err)
	}
	// simplest relay-compliant graphql server HTTP handler
	hndlr := handler.New(&handler.Config{
		Schema: &schema,
		Pretty: true,
	})

	http.Handle("/graphql", hndlr)

	//non changeable
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("static"))))
	http.ListenAndServe(":8090", nil) //setp-1
}
