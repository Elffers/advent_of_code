package main

import(
	"io/ioutil"
	"fmt"
	"strings"
	"strconv"
)

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day01.in")
	if err != nil {
		panic(err)
	}
	nums := inputToIntSlice(string(input))
	count := 0
	for i, s := range nums {
		if i == 0 {
			continue
		}
		if s-nums[i-1] > 0 {
			count += 1
		}
	}
	fmt.Print(count)
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

