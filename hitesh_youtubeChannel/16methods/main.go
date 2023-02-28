package main

import (
	"fmt"
)

func main() {

	fmt.Println("Welcome to Struct Tutorial")

	hitesh := User{"hitesh", "abc@mail.com", true, 10}
	fmt.Println(hitesh)
	fmt.Printf("My details are:%+v\n", hitesh)
	fmt.Printf("Name is %v and Email is%v \n", hitesh.Name, hitesh.Email)

	hitesh.GetStatus()
	hitesh.GetMail()
	fmt.Printf("Name is %v and Email is%v \n", hitesh.Name, hitesh.Email)

}

type User struct {
	Name   string
	Email  string
	Status bool
	Age    int
}

func (u User) GetStatus() {
	fmt.Println("Is User Active: ", u.Status)
}

func (u User) GetMail() {
	u.Email = "new@mail.com"
	fmt.Println("New Email is : ", u.Email)
}
