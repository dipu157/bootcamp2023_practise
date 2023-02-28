package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {

	rand.Seed(time.Now().UnixNano())
	diceNumber := rand.Intn(6) + 1
	fmt.Println("Value of dice is ", diceNumber)

	switch diceNumber {
	case 1:
		fmt.Println("Dice value is 1 and you can open")

	case 2:
		fmt.Println("Youcan move 2 step")

	case 3:
		fmt.Println("Youcan move 3 step")

	case 4:
		fmt.Println("Youcan move 4 step")

	case 5:
		fmt.Println("Youcan move 5 step")
	case 6:
		fmt.Println("Youcan move 6 step and play dice again")
	default:
		fmt.Println("What was that")
	}

}
