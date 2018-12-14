package main

import (
	"fmt"
	"strconv"
)


func main() {
	// input := "084601"
	// input := []int{0,8,4,6,0,1}
	input := "59414"
	n, _ := strconv.Atoi(input)
	fmt.Println(n)

	scores := []int{3, 7}
	i1, i2 := 0, 1
	for {
		// for i := 0; i < n; i++ {
		r1, r2 := scores[i1], scores[i2]
		score := r1 + r2
		a := score / 10
		b := score % 10
		if a != 0 {
			scores = append(scores, a)
		}
		scores = append(scores, b)

		i1 = (i1 + r1 + 1) % len(scores)
		i2 = (i2 + r2 + 1) % len(scores)

		if len(scores) >= len(input) {
			n := len(scores) - len(input)
			pattern := ""

			for _, s := range scores[n:len(scores)] {
				c := strconv.Itoa(s)
				pattern = pattern +c
				// fmt.Printf("pattern: %+v\n", pattern)
			}
			if pattern == input {
				fmt.Printf("Part 2 pattern: %+v\n", n)
				break
			}

		}

	}
	// Part 1
	// fmt.Println(scores[n:n+10])
}
