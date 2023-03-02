package main

import (
	"encoding/json"
	"fmt"
)

type courses struct {
	Name     string `json:"coursename"`
	Price    int
	Platform string   `json:"website"`
	Password string   `json:"-"`
	Tags     []string `json:"tags,omitempty"`
}

func main() {
	fmt.Println("Welcome To JSON")

	EncodeJson()
}

func EncodeJson() {
	lcoCourses := []courses{
		{"ReactJs", 299, "abcOnline.com", "abc123", []string{"web-dev", "js"}},
		{"AngularJs", 199, "abcOnline.com", "abcd123", []string{"full-stack", "js"}},
		{"VueJs", 99, "abcOnline.com", "abce123", nil},
	}

	// package this data as JSON data
	finalJson, err := json.MarshalIndent(lcoCourses, "lco", "\t")
	if err != nil {
		panic(err)
	}
	fmt.Printf("%s\n", finalJson)
}
