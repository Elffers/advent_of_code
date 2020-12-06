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

	p1 := 0

	for _, g := range groups {
		unique := make(map[rune]bool)
		g = strings.ReplaceAll(g, "\n", "")
		for _, c := range g {
			unique[c] = true
		}
		p1 += len(unique)
	}
	fmt.Println(p1)
}
