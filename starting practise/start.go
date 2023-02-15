package main

import (
	"fmt"
	// "reflect"
)

func main() {
	// var student1 string = "John" //type is string
	// var student2 = "Jane" //type is inferred
	// x := 2 //type is inferred

	var name string
	var age int

	fmt.Println("Enter Your Name & Age: ")
	fmt.Scanf("%s %d",&name, &age)
	fmt.Printf("Your name is %s & age is %d",name,age)

	// fmt.Println(x)
	// fmt.Println("Type of student2:",reflect.TypeOf(student2))
	// fmt.Println("Type of x:",reflect.TypeOf(x))

	// var chr rune
	// chr = '$'

	// fmt.Println(chr)
}
