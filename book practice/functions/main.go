package main

import "fmt"

// func add(args ...int) int {
// 	total := 0
// 	for _, v := range args {
// 		total += v
// 	}
// 	return total
// }

func main() {

	second()
	defer first()
	third()

}

func first() {
	fmt.Println("1st")
}
func second() {
	fmt.Println("2nd")
}
func third() {
	fmt.Println("Third")
}
