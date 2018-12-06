package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func React(polymer string) int {
	reduced := []byte{}

	el := polymer[0]
	polymer = polymer[1:]
	reduced = append(reduced, el)

	for len(polymer) > 0 {
		b := polymer[0]
		polymer = polymer[1:]

		if len(reduced) < 1 {
			reduced = append(reduced, b)
			continue
		}

		a := reduced[len(reduced)-1]
		if a-b == 32 || b-a == 32 {
			reduced = reduced[0 : len(reduced)-1]
		} else {
			reduced = append(reduced, b)
		}
	}

	return len(reduced)
}

func FindShortest(polymer string) int {
	min := 10000
	letters := "abcdefghijklmnopqrstuvwxyz"

	for _, l := range letters {
		letter := string(l)
		r := strings.NewReplacer(letter, "", strings.ToUpper(letter), "")
		p := r.Replace(polymer)
		size := React(p)
		if size < min {
			min = size
		}
	}

	return min
}

func main() {
	input, err := ioutil.ReadFile("../../inputs/day5.in")
	if err != nil {
		panic(err)
	}
	polymer := strings.TrimSpace(string(input))
	// polymer = "dabAcCaCBAcCcaDA"
	fmt.Printf("Day 5 Part 1: %+v\n", React(polymer))
	fmt.Printf("Day 5 Part 2: %+v\n", FindShortest(polymer))
}
