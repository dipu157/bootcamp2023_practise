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

	// EncodeJson()
	DecodeJson()
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

func DecodeJson() {
	jsonDataFromWeb := []byte(`
	{
		"coursename": "VueJs",
		"Price": 99,
		"website": "abcOnline.com",
		"tags": ["web-dev","js"]
	}
`)

	var lcoCourse courses

	checkValid := json.Valid(jsonDataFromWeb)

	if checkValid {
		fmt.Println("JSON was valid")
		json.Unmarshal(jsonDataFromWeb, &lcoCourse)
		fmt.Printf("%#v", lcoCourse)
	} else {
		fmt.Println("JSON was not valid")
	}

	// some cases for add data as key value

	var myOnlineData map[string]interface{}
	json.Unmarshal(jsonDataFromWeb, &myOnlineData)
	fmt.Printf("%#v\n", myOnlineData)

	for k, v := range myOnlineData {
		fmt.Printf("key is %v and value is %v and type is %T\n", k, v, v)
	}
}

/*
You skipped a very important topic there. var lcoCourse course definition style is new to users and deserves further explanation.

var lcoCourse course is same as var lcoCourse = course{}.
From what I understand, we create here an instance of the course struct that was defined earlier. Yet, this instant is updated once the Unmarshal function is called and &lcoCourse is used. So, lcoCourse in this scenario is mutable (can be changed)

Another very important note: var lcoCourse = course{} is completely different than var lcoCourse = []course{}. The second one is creating a new method from my research that is immutable (cannot be changed). Therefore we use course{} here.

Feel free to try it yourself and also print the lcoCourse before and after Unmarshal is applied. You will see the difference. I hope Hitesh will explain this in details in upcoming classes.

*/
