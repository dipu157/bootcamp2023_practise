package main

import (
	"fmt"
	"os"
)

func main() {

	// dir, err := os.Getwd()

	// if err != nil {
	// 	fmt.Println(err.Error())
	// }

	// fmt.Println(dir)

	isErr := createFile("second_file.txt", "Yap, Golang is awesome")
	fmt.Println(isErr)

}

func createFile(filename, content string) bool {

	posf, err := os.Create(filename)
	if err != nil {
		fmt.Println(err.Error())
		return false
	}

	defer posf.Close()

	_, err = posf.Write([]byte(content))
	if err != nil {
		return false
	}

	return true
}
