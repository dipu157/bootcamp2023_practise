package main

import (
	"fmt"
)

func main() {

	myNumber := 10
	var ptr = &myNumber

	fmt.Println("The value of ptr is", ptr)
	fmt.Println("The value of ptr is", *ptr)
	fmt.Println("The value of myNumber is", myNumber)

	*ptr = *ptr + 5
	fmt.Println("The new value of myNumber is :", myNumber)
}
