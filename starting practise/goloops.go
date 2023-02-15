package main

import (
	"fmt"
)

func main() {
	fruits := [4]string{"apple", "orange", "banana", "Papaya"}
	for idx, val := range fruits {
		fmt.Printf("%v\t%v\n", idx, val)
	}
}
