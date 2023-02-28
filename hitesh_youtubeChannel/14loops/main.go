package main

import "fmt"

func main() {
	days := []string{"sunday", "monday", "wednesday", "friday"}

	fmt.Println(days)

	// for d := 0; d < len(days); d++ {
	// 	fmt.Println(days[d])
	// }

	// for i := range days {
	// 	fmt.Println(days[i])
	// }

	// for index, day := range days {
	// 	fmt.Printf("index is %v and value is %v \n", index, day)
	// }

	roughValue := 1
	for roughValue < 10 {

		if roughValue == 2 {
			goto lco
		}

		if roughValue == 5 {
			roughValue++
			continue
		}

		fmt.Println("Value is :", roughValue)
		roughValue++

	}

lco:
	fmt.Println("Value is 2")
}
