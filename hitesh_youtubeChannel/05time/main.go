package main

import (
	"fmt"
	"time"
)

func main() {

	presentTime := time.Now()
	//fmt.Println(presentTime)

	fmt.Println(presentTime.Format("02-01-2006 Monday 15:04:05"))

	createDate := time.Date(1991, time.December, 5, 10, 55, 30, 25, time.UTC)
	//fmt.Println(createDate)
	fmt.Println(createDate.Format("02-01-2006 Monday"))
}
