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
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day10.in")
	if err != nil {
		panic(err)
	}
	adapters := format(string(input))

	d1, d3 := 0, 0

	prev := adapters[0]

	set := make(map[int]bool) // for part 2

	for i, a := range adapters {
		set[a] = true
		if i == 0 {
			continue
		}
		diff := a-prev
		if diff == 1 {
			d1 += 1
		}
		if diff == 3 {
			d3 += 1
		}
		prev = a
	}

	fmt.Printf("part 1: %v\n", d1*d3)

	graph := make(map[int]int)
	graph[0] = 1

	// need to get rid of first 0 in adapters
	for _, a := range adapters[1:] {
		choices := []int{a-1, a-2, a-3}
		var combos int
		for _, c := range choices {
			if _, ok := set[c]; ok {
				combos += graph[c]
			}
		}
		graph[a] = combos
	}

	device := adapters[len(adapters)-1]

	fmt.Printf("part 2: %v\n", graph[device])
}

