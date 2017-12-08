package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"

	"aoc/2017/arrays"
)

func distribute(buckets []int) []int {
	max := arrays.Max(buckets)
	i := indexOfMax(max, buckets)

	buckets[i] = 0
	offset := (i + 1) % len(buckets)

	for max > 0 {
		buckets[offset] += 1
		offset = (offset + 1) % len(buckets)
		max--
	}

	return buckets
}

func indexOfMax(max int, buckets []int) int {
	for i, val := range buckets {
		if val == max {
			return i
		}
	}

	return 0
}

func keyFor(buckets []int) string {
	nums := make([]string, len(buckets))
	for i, val := range buckets {
		s := strconv.Itoa(val)
		nums[i] = s
	}

	return strings.Join(nums, " ")
}

func process(input []byte) []int {
	raw := strings.Fields(string(input))

	buckets := make([]int, len(raw))

	for i, n := range raw {
		buckets[i], _ = strconv.Atoi(n)
	}

	return buckets
}

func main() {
	input, err := ioutil.ReadFile("day6.in")

	if err == nil {
		buckets := process(input)

		steps := 0
		seen := make(map[string]int)
		key := keyFor(buckets)

		for seen[key] == 0 {
			seen[key] = steps
			buckets = distribute(buckets)
			key = keyFor(buckets)
			steps++
		}

		fmt.Printf("steps: %v\n", steps)
		fmt.Printf("cycles: %v\n", steps-seen[key])
	}
}
