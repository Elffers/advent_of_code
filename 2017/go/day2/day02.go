package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"

	"aoc/2017/arrays"
)

func Checksum(in string, f func([]int) int) int {
	rows := strings.Split(in, "\n")
	sum := 0
	for _, row := range rows {
		nums := convertRow(row)
		sum += f(nums)
	}
	return sum
}

func findDiff(nums []int) int {
	return arrays.Max(nums) - arrays.Min(nums)
}

func quotient(nums []int) int {
	for i, num := range nums {
		for j, div := range nums {
			if i == j {
				continue
			}
			if num % div == 0 {
				return num / div
			}
		}
	}
	return 0
}

func convertRow(row string) []int {
	nums := strings.Split(row, "\t")
	out := make([]int, len(nums))
	for i, num := range nums {
		n, err := strconv.Atoi(num)
		if err == nil {
			out[i] = n
		}
	}

	return out
}

func main() {
	input, err := ioutil.ReadFile("day2.in")
	if err == nil {
		in := string(input)
		fmt.Printf("Day 1 Part 1: %v\n", Checksum(in, findDiff))
		fmt.Printf("Day 1 Part 1: %v\n", Checksum(in, quotient))
	}
}
