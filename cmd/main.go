package main

import (
	"fmt"
	database "go_bikes/internal"
)

func main() {
	err := database.Connect()
	if err != nil {
		fmt.Print(err)
		return
	}
}
