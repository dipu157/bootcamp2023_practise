package main

import (
	"fmt"
	"sort"
)

func main() {
	arr := [5]int{10, 2, 8, 4, 5}
	x := arr[:5]

	fmt.Println(x)
	fmt.Println(sort.IntsAreSorted(x))

}
