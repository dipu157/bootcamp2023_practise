package main

import "fmt"

func main() {
	fmt.Println("welcome To Function!")

	proRes, message := proAdder(5, 5, 10, 20)
	fmt.Println("Pro Result is: ", proRes)
	fmt.Println("Pro mesage is: ", message)
}

func proAdder(nums ...int) (int, string) {
	total := 0
	for _, val := range nums {
		total += val
	}
	return total, "Hello, Kitty"
}
