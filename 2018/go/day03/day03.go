package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func Populate(claims map[int]Claim) (fabric [1000][1000][]int) {
	for id, claim := range claims {
		for i := claim.X; i < claim.X + claim.Width; i++ {
			for j := claim.Y; j < claim.Y + claim.Length; j++ {
				fabric[j][i] = append(fabric[j][i], id)
			}
		}
	}
	return
}

func Overlap(claims map[int]Claim) int {
	overlaps := 0
	fabric := Populate(claims)

	for _, row := range fabric {
		for _, col := range row {
			if len(col) > 1 {
				overlaps++
			}
		}
	}
	return overlaps
}


func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3.in")
	if err != nil {
		panic(err)
	}
	claims := formatInput(string(input))

	fmt.Printf("Day 3 Part 1: %+v\n", Overlap(claims))
}

type Claim struct {
	X int
	Y int
	Width int
	Length int
	Overlap bool
}

func formatInput(input string) map[int]Claim {
	lines := strings.Split(input, "\n")
	claims := map[int]Claim{}
	for _, line := range lines {

		var id, x, y, w, l int
		// #1 @ 749,666: 27x15
		fmt.Sscanf(line, "#%d @ %d,%d: %dx%d", &id, &x, &y, &w, &l)
		c := Claim{x, y, w, l, false}

		claims[id] = c
	}
	return claims
}
