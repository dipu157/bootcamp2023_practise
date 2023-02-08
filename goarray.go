package main

import (
	"fmt"
	// "reflect"
)

func main() {

	var student [3] string

	student[0] = "Amin"
	student[1] = "Babul"
	student[2] = "Sifat "

	employees := [3]string{"arwa","Bokul","rahi"}

	fmt.Println(student)
	fmt.Println(len(student))
	fmt.Println(student[2])
	fmt.Println(employees)
}