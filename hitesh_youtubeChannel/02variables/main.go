package main

import "fmt"

func main() {
	var isLoggedIn bool = false

	fmt.Println(isLoggedIn)
	fmt.Printf("variable is of type: %T \n", isLoggedIn)

	// implicit type
	var website = "erahbar.com"
	fmt.Println(website)

	// no var style

	numberofUser := 3000
	fmt.Println(numberofUser)
}
