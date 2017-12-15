package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("../../day10.in")

	if err == nil {
		input := strings.TrimSpace(string(input))
		fmt.Println(input)
	}
}
