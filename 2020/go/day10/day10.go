package main

import(
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
	"sort"
)

func format(input string) []int {
	adapters := strings.Split(string(input), "\n")

	out := []int{}
	max := 0
	for _, a := range adapters {
		x, _ := strconv.Atoi(a)
		if x > max {
			max = x
		}
		out = append(out, x)
	}
	out = append(out, max+3)
	sort.Ints(out)
	return out
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day10test.in")
	if err != nil {
		panic(err)
	}
	adapters := format(string(input))

	graph := make(map[int][]int)

	for _, a := range adapters {
		choices := []int{a+1, a+2, a+3}
		for _, c := range choices {
			if 
			graph[a] 
		}
	}


	fmt.Printf("part 1: %v\n", adapters )
}

