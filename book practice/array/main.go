package main

import "fmt"

func main() {
	// var x [5]int
	// x[1], x[3] = 100, 10
	// fmt.Println(x[1])

	// slice1 := []int{1, 2, 3}
	// slice2 := []int{4, 5, 6}
	// slice3 := append(slice1, slice2...)

	// fmt.Printf("The output is : ")
	// fmt.Println(slice3)

	// slice1 := []int{1, 2, 3}
	// slice2 := make([]int, 3)
	// copy(slice2, slice1)

	// fmt.Printf("The output is : ")
	// fmt.Println(slice1, slice2)

	//var x map[string]int
	// x := make(map[int]int)
	// x[10] = 10
	// fmt.Println(len(x))

	elements := make(map[string]string)
	// elements["Li"] = "Lithium"
	// fmt.Println(elements["Li"])
	name, ok := elements["Un"]
	fmt.Println(name, ok)

}
