package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("day5.in")
	if err == nil {
		in := strings.TrimSpace(string(input))
		nums := strings.Split(in, "\n")
		finish := len(nums)
		jumps := make([]int, finish)
		for i, num := range nums {
			jumps[i], _ = strconv.Atoi(num)
		}

		i, steps := 0, 0
		for i < finish {
			j := i
			jump := jumps[j]

			i += jump
			steps += 1

			if jump > 2 {
				jumps[j] = jump - 1
			} else {
				jumps[j] = jump + 1
			}
		}

		fmt.Println(steps)
	}
}
