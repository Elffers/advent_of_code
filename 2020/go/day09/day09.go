package main

import (
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func sum_in(n int, window []int) bool {
	set := make(map[int]bool)
	for _, n := range window {
		set[n] = true
	}

	for _, x := range window {
		complement := n - x
		if _, ok := set[complement]; ok {
			if complement != x {
				return true
			}
		}
	}
	return false
}

func part1(nums []int) int {
	x, y := 0, 25
	window := nums[x:y]
	queue := nums[y : len(nums)-1]

	for len(queue) > 0 {
		num := queue[0]
		queue = queue[1:len(queue)]

		if !sum_in(num, window) {
			return num
		}
		x += 1
		y += 1
		window = nums[x:y]
	}
	return 0
}

func part2(target int, nums []int) int {
	x := 0
	y := x + 2

	for y < len(nums) {
		window := nums[x:y]
		sum := 0
		min := window[0]
		max := window[0]
		for _, n := range window {
			if n < min {
				min = n
			}
			if n > max {
				max = n
			}
			sum += n
		}
		if sum == target {
			return min + max
		}
		if sum < target {
			y += 1
		}
		if sum > target {
			x += 1
			y = x + 1
		}
	}

	return 0
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day09.in")
	if err != nil {
		panic(err)
	}
	split := strings.Split(string(input), "\n")
	nums := []int{}
	for _, s := range split {
		n, _ := strconv.Atoi(s)
		nums = append(nums, n)
	}

	num := part1(nums)
	fmt.Printf("part 1: %v\n", num)

	res := part2(num, nums)
	fmt.Printf("part 2: %v", res)
}
