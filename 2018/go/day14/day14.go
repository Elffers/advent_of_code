package main

import (
	"fmt"
	"strconv"
)


func main() {
	input := "084601"
	n, _ := strconv.Atoi(input)

	scores := []int{3, 7}
	i1, i2 := 0, 1
	for i := 0; i < n; i++ {
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
	}
	// Part 1
	fmt.Println(scores[n:n+10])

	// fmt.Printf("Day 14 Part 2: %+v\n", part2)
}
