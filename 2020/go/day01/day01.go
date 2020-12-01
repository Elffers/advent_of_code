package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

// findPair finds pair of numbers whose sum is 2020 and returns their product
func findPair(nums map[int]bool) int {
	for num, _ := range nums {
		p := 2020 - num
		if nums[p] {
			return num * p
		}
	}
	return 0
}

func findTrio(nums []int) int {
	for i, x := range nums {
		for j, y := range nums[i+1:] {
			for _, z := range nums[j+1:] {
				if x + y + z == 2020 {
					return x*y*z
				}
			}
		}
	}
	return 0
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day01.in")
	if err != nil {
		panic(err)
	}
	nums := formatInputToMap(string(input))
	numSlice := formatInputToSlice(string(input))

	fmt.Printf("Day 1 Part 1: %+v\n", findPair(nums))
	fmt.Printf("Day 1 Part 2: %+v\n", findTrio(numSlice))
}

// converts input string into a "set"
func formatInputToMap(input string) map[int]bool {
	numbers := strings.Split(input, "\n")
	out := make(map[int]bool)

	for _, s := range numbers {
		i, err := strconv.Atoi(s)
		if err == nil {
			out[i] = true
		}
	}
	return out
}

func formatInputToSlice(input string) []int {
	numbers := strings.Split(input, "\n")
	out := []int{}

	for _, s := range numbers {
		i, err := strconv.Atoi(s)
		if err == nil {
			out = append(out, i)
		}
	}
	return out
}

