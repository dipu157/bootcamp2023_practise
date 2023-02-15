package main

import "fmt"

// "reflect"

type Person struct {
	name   string
	age    int
	job    string
	salary float32
}

func main() {

	var pers1 Person
	var pers2 Person

	pers1.name = "Arob"
	pers1.age = 28
	pers1.job = "Arob"
	pers1.salary = 20216.25

	pers2.name = "Arob"
	pers2.age = 28
	pers2.job = "Arob"
	pers2.salary = 20216.25

	// Access and print Pers1 info
	fmt.Println("Name: ", pers1.name)
	fmt.Println("Age: ", pers1.age)
	fmt.Println("Job: ", pers1.job)
	fmt.Println("Salary: ", pers1.salary)

	// Access and print Pers2 info
	fmt.Println("Name: ", pers2.name)
	fmt.Println("Age: ", pers2.age)
	fmt.Println("Job: ", pers2.job)
	fmt.Println("Salary: ", pers2.salary)

}
