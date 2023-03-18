package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
)

func main() {

	http.HandleFunc("/process", process)

	//non changeable
	//http.Handle("/resources/", http.StripPrefix("/resources/", http.FileServer(http.Dir("assets")))) //step-2
	http.ListenAndServe(":8080", nil) //setp-1
}

func process(w http.ResponseWriter, r *http.Request) {

	//r.ParseForm()

	defer func() {
		if rec := recover(); rec != nil {
			fmt.Println("apiHandler panicking >>", rec)
		}
	}()

	if r.Method == http.MethodPost {

		r.ParseMultipartForm(r.ContentLength)

		fmt.Println("PostForm>", r.PostForm)

		name := r.FormValue("name")
		email := r.FormValue("email")
		phone := r.FormValue("phone")
		fmt.Println(r.Method, name, email, phone)

		for key, val := range r.MultipartForm.Value {
			//fmt.Printf("%s %T %v\n", key, val, val)
			fmt.Println(key, val)
		}

		//open
		// file, header, err := r.FormFile("") //file-0
		// if err != nil {
		// 	return
		// }

		// defer file.Close()
		// //read file data
		// bs, err := ioutil.ReadAll(file)
		// if err != nil {
		// 	return
		// }

		for key, f := range r.MultipartForm.File {

			fmt.Println(key, f)
			for i, fh := range f {

				fmt.Println(i, fh.Filename, fh.Size, fileProcess(fh))

			}

		}

		//var rdata map[string]interface{}
		//json.NewDecoder(r.Body).Decode(&rdata)
		//fmt.Println(rdata)
		w.Header().Set("Access-Control-Allow-Origin", "*")             //Response to preflight request doesn't pass access control check: No 'Access-Control-Allow-Origin' header is present on the requested resource
		w.Header().Set("Access-Control-Allow-Methods", "POST,GET")     //optional ->  POST,GET,OPTIONS,PUT,DELETE
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type") //Access to fetch at .... has been blocked by CORS policy
		// use proper JSON Header
		//w.Header().Set("Content-Type", "application/json; charset=utf-8")
		w.Header().Set("Content-Type", "application/json")

		//json output
		row := make(map[string]interface{})
		row["response"] = "success"
		row["request"] = r.MultipartForm.Value

		bs, err := json.Marshal(row)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		fmt.Println(string(bs))
		fmt.Fprintln(w, string(bs))
	}

}

func fileNameWithoutExt(fileName string) string {
	return fileName[:len(fileName)-len(filepath.Ext(fileName))]
}

func fileProcess(fh *multipart.FileHeader) error {

	//file processing
	file, err := fh.Open()
	if err != nil {
		log.Println(err)
		return err
	}
	defer file.Close()

	bs, err := ioutil.ReadAll(file)
	if err != nil {
		return err
	}

	fbase := fileNameWithoutExt(fh.Filename)
	//fmt.Println("fbase", fbase)

	ext := filepath.Ext(fh.Filename)
	newFileName := fmt.Sprintf("%s.%s", fbase, ext)
	uploadLocation := "./img"
	fileName := filepath.Join(uploadLocation, newFileName)
	pFile, err := os.OpenFile(fileName, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0756)
	if err != nil {
		return err
	}
	defer pFile.Close()

	_, err = pFile.Write(bs)
	if err != nil {
		return err
	}
	return nil
}
