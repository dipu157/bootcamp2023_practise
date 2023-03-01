package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

const url = "https://w3schools.com"

func main() {
	response, err := http.Get(url)
	if err != nil {
		panic(err)
	}

	fmt.Printf("Response is of Type: %T\n", response)

	defer response.Body.Close()

	dataTypes, err := ioutil.ReadAll(response.Body)
	if err != nil {
		panic(err)
	}
	content := string(dataTypes)
	fmt.Println(content)

}
