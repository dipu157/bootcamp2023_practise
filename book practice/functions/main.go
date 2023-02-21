package main

import "fmt"

func add(args ...int) int {
	total := 0
	for _, v := range args {
		total += v
	}
	return total
}

func main() {
	fmt.Println(add(1, 2, 3, 10, 20))
	//fmt.Println(f1())
}

// func f1() int {
// 	return f2()
// }

// func f2() int {
// 	return 10
// }
