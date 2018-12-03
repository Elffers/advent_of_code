package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func Populate(claims map[int]Claim) (fabric [1000][1000][]int) {
	for id, claim := range claims {
		for i := claim.X; i < claim.X+claim.Width; i++ {
			for j := claim.Y; j < claim.Y+claim.Length; j++ {
				fabric[j][i] = append(fabric[j][i], id)
			}
		}
	}
	return
}

func Overlap(claims map[int]Claim) (int, int) {
	overlaps, unclaimed := 0, 0
	fabric := Populate(claims)
	claimed := make(map[int]bool)

	for _, row := range fabric {
		for _, col := range row {
			if len(col) > 1 {
				overlaps++
				for _, claim_id := range col {
					claimed[claim_id] = true
				}
			}
		}
	}

	for id, _ := range claims {
		if _, ok := claimed[id]; !ok {
			unclaimed = id
		}
	}

	return overlaps, unclaimed
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day3.in")
	if err != nil {
		panic(err)
	}
	claims := formatInput(string(input))
	part1, part2 := Overlap(claims)
	fmt.Printf("Day 3 Part 1: %+v\n", part1)
	fmt.Printf("Day 3 Part 2: %+v\n", part2)
}

type Claim struct {
	X      int
	Y      int
	Width  int
	Length int
}

func formatInput(input string) map[int]Claim {
	lines := strings.Split(input, "\n")
	claims := map[int]Claim{}
	for _, line := range lines {
		var id, x, y, w, l int
		// #1 @ 749,666: 27x15
		fmt.Sscanf(line, "#%d @ %d,%d: %dx%d", &id, &x, &y, &w, &l)
		c := Claim{x, y, w, l}

		claims[id] = c
	}
	return claims
}
