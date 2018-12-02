package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func Sum(freqs []int) int {
	sum := 0
	for _, f := range freqs {
		sum += f
	}
	return sum
}

func Calibrate(freqs []int) int {
	seen := make(map[int]bool)
	current := 0
	seen[current] = true
	i := 0

	for {
		idx := i % len(freqs)
		f := freqs[idx]
		current += f

		if seen[current] {
			return current
		}

		i++
		seen[current] = true
	}
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day1.in")
	if err != nil {
		panic(err)
	}
	freqs := formatInput(string(input))

	fmt.Printf("Day 1 Part 1: %+v\n", Sum(freqs))
	fmt.Printf("Day 1 Part 2: %+v\n", Calibrate(freqs))
}

func formatInput(input string) []int {
	freq_str := strings.Split(input, "\n")
	out := []int{}

	for _, s := range freq_str {
		i, err := strconv.Atoi(s)
		if err == nil {
			out = append(out, i)
		}
	}
	return out
}
