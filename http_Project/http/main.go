package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	nl, err := net.Listen("tcp", ":8888")
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	conn, err := nl.Accept()
	if err != nil {
		fmt.Println(err.Error())
	}

	bs := make([]byte, 1024)

	n, e := conn.Read(bs)

	if e != nil {
		fmt.Println(e.Error())
	}

	fmt.Println(n)
	reqstr := string(bs)
	fmt.Println(reqstr)

	body := `<!DOCTYPE html> <html><head><title>Page Title</title></head><body><h1>My First Heading</h1><p>My first paragraph.</p></body></html>`

	resp := "HTTP/1.1 200 Ok\r\n" +
		"Content-Length: %d\r\n" +
		"Content-Type text/html\r\n" +
		"\r\n%s"

	msg := fmt.Sprintf(resp, len(body), body)
	fmt.Println(msg)
	conn.Write([]byte(msg))

}
