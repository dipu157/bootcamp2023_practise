package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
)

func main() {
	fmt.Println("Welcome To Web Verb")
	PerformanceGetRequest()

}

func PerformanceGetRequest() {
	const myurl = "http://localhost:8000/get"

	response, err := http.Get(myurl)
	if err != nil {
		panic(err)
	}

	defer response.Body.Close()

	fmt.Println("Status Code: ", response.StatusCode)
	fmt.Println("Content length is: ", response.ContentLength)

	content, _ := ioutil.ReadAll(response.Body)

	var responseString strings.Builder
	fmt.Println(string(content))
	byteCount, _ := responseString.Write(content)

	fmt.Println("Bytecount is :", byteCount)
	fmt.Println(responseString.String())
}
