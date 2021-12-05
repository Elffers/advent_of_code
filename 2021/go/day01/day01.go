package main

import(
	"io/ioutil"
	"fmt"
	"strings"
	"strconv"
)

func countIncreases(nums []int) int {
	count := 0
	for i, n := range nums {
		if i == 0 {
			continue
		}
		if n-nums[i-1] > 0 {
			count += 1
		}
	}
	return count
}

func countWindowIncreases(nums []int) int {
	count := 0
	prevSum := nums[0] + nums[1] + nums[2]
	for i, _ := range nums {
		if i == 0 || i == 1 || i == 2 {
			continue
		}
	currSum := nums[i] + nums[i-1] + nums[i-2]
		if currSum-prevSum > 0 {
			count += 1
		}
	prevSum = currSum
	}
	return count
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day01.in")
	if err != nil {
		panic(err)
	}
	nums := inputToIntSlice(string(input))
	fmt.Printf("Part 1: %+v\n", countIncreases(nums))
	fmt.Printf("Part 2: %+v\n", countWindowIncreases(nums))
}

func inputToIntSlice(input string) []int {
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
