package main

import (
	"fmt"
	"strconv"
)

func main() {
	input := "084601"
	n, _ := strconv.Atoi(input)

	scores := map[int]int{
		0: 3,
		1: 7,
	}

	i1, i2 := 0, 1
	next_index := 2

	for {
		r1, r2 := scores[i1], scores[i2]
		score := r1 + r2
		a := score / 10
		b := score % 10
		if a != 0 {
			scores[next_index] = a
			next_index++

			if next_index >= len(input) {
				n := next_index - len(input)
				pattern := ""
				for i := n; i < next_index; i++ {

					c := strconv.Itoa(scores[i])
					pattern = pattern + c
				}
				if pattern == input {
					fmt.Printf("Part 2 pattern: %+v\n", n)
					break
				}
			}
		}

		scores[next_index] = b
		next_index++

		if next_index >= len(input) {
			n := next_index - len(input)
			pattern := ""
			for i := n; i < next_index; i++ {
				c := strconv.Itoa(scores[i])
				pattern = pattern + c
			}

			if pattern == input {
				fmt.Printf("Part 2: %+v\n", n)
				break
			}
		}
		i1 = (i1 + r1 + 1) % next_index
		i2 = (i2 + r2 + 1) % next_index

		// Part 1
		if next_index == n+10 {
			pattern := ""
			for i := n; i < n+10; i++ {
				c := strconv.Itoa(scores[i])
				pattern = pattern + c
			}
			fmt.Printf("Part 1: %v\n", pattern)
		}
	}
}
// Part 1: 2688510125
// Part 2 pattern: 20188250
