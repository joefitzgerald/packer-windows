package main

import (
	"log"
	"net/http"
)

func main() {
	http.Handle("/", http.StripPrefix("/", http.FileServer(http.Dir("."))))
	if err := http.ListenAndServe(":8000", nil); err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
