package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func score(input string) (score int, garbage int) {
	depth := 0

	i := 0
	for i < len(input) {
		char := input[i]
		switch char {
		case '{':
			depth++
		case '}':
			score += depth
			depth--
		case '<':
			i++
			g := input[i]
			for g != '>' {
				if g == '!' {
					i++
				} else {
					garbage++
				}
				i++
				g = input[i]
			}
		}
		i++
	}

	return score, garbage
}

func main() {
	input, err := ioutil.ReadFile("../../day9.in")

	if err == nil {
		input := strings.TrimSpace(string(input))
		fmt.Println(score(input))
	}
}
