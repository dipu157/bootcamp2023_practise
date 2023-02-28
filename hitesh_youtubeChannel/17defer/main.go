package main

import "fmt"

func main() {
	fmt.Println("Welcome To Defer")
	defer fmt.Println("one")
	fmt.Println("Hello, World")

	defer fmt.Println("two")
	defer fmt.Println("second")
}
