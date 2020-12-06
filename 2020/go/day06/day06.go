package main

import(
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day06.in")
	if err != nil {
		panic(err)
	}
	groups := strings.Split(string(input), "\n\n")

	p1, p2 := 0, 0

	for _, g := range groups {
		unique := make(map[rune]int)
		s := strings.ReplaceAll(g, "\n", "")
		for _, c := range s {
			unique[c] += 1
		}
		p1 += len(unique)

		size := len(strings.Split(g, "\n"))
		for _, count := range unique {
			if count == size {
				p2 += 1
			}
		}
	}
	fmt.Printf("part 1: %d\n", p1)
	fmt.Printf("part 2: %d\n", p2)
}
