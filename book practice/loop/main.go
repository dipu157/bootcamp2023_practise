package main

import "fmt"

func main() {

	// for i := 0; i <= 10; i++ {
	// 	if i%2 == 0 {
	// 		fmt.Println(i, " Even")
	// 	} else {
	// 		fmt.Println(i, " odd")
	// 	}

	// }

	fmt.Println("Enter the age : ")
	var age int
	fmt.Scanf("%d", &age)

	switch age {
	case 0, 1:
		fmt.Println("Infant")

	case 2, 3, 4, 5:
		fmt.Print("Baby")

	case 6, 7, 8, 9:
		fmt.Print("Growing")

	default:
		fmt.Println("You Enter Wrong Age")
	}
}
