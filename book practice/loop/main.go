package main

import "fmt"

func main() {

	for i := 1; i <= 100; i++ {
		if i%3 == 0 && i%5 != 0 {
			fmt.Println("Fizz")
		} else if i%5 == 0 && i%3 != 0 {
			fmt.Println("Buzz")
		} else if i%3 == 0 && i%5 == 0 {
			fmt.Println("FizzBuzz")
		}

	}

	// fmt.Println("Enter the age : ")
	// var age int
	// fmt.Scanf("%d", &age)

	// switch age {
	// case 0, 1:
	// 	fmt.Println("Infant")

	// case 2, 3, 4, 5:
	// 	fmt.Print("Baby")

	// case 6, 7, 8, 9:
	// 	fmt.Print("Growing")

	// default:
	// 	fmt.Println("You Enter Wrong Age")
	// }
}
