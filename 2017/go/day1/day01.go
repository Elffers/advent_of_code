package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func Sum(input string) int {
	sum := 0
	// Account for circular list
	if input[0] == input[len(input)-1] {
		digit, err := strconv.Atoi(string(input[0]))
		if err == nil {
			sum += digit
		}
	}
	current, input := input[0], input[1:]
	for len(input) > 0 {
		if current == input[0] {
			digit, err := strconv.Atoi(string(current))
			if err == nil {
				sum += digit
			}
		}
		current, input = input[0], input[1:]
	}

	return sum
}

func HalfSum(input string) int {
	sum := 0
	offset := len(input) / 2
	half := input[:offset]
	for i, d := range half {
		if byte(d) == input[i+offset] {
			digit, err := strconv.Atoi(string(d))
			if err == nil {
				sum += 2 * digit
			}
		}
	}

	return sum
}

func main() {
	digits, err := ioutil.ReadFile("./day01.in")
	if err == nil {
		input := strings.TrimSpace(string(digits))
		fmt.Printf("Day 1 Part 1: %+v\n", Sum(input))
		fmt.Printf("Day 1 Part 2: %+v\n", HalfSum(input))
	}
}
