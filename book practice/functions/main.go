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

	// second()
	// defer first()
	// third()

	b := new(int)
	one(b)
	fmt.Println(*b)

}

func one(a *int) {
	*a = 1
}

// func first() {
// 	fmt.Println("1st")
// }
// func second() {
// 	fmt.Println("2nd")
// }
// func third() {
// 	fmt.Println("Third")
// }
