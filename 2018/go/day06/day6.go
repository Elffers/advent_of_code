package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"math"
)
func FindLargestArea(coords [][]int) int {
	l, r, t, b := findBounds(coords)
	infinite := make(map[int]bool)
	areas := make(map[int]int)
	// var grid [500][500][]int // only needed for visualization/debugging

	for i := 0; i <= r; i++ {
		for j := 0; j <= b; j++ {
			pt := []int{i, j}
			closestPoints := findClosest(pt, coords)

			// populate grid
			// grid[j][i] = closestPoints

			// count area for each coordinate
			if len(closestPoints) == 1 {
				areaFor := closestPoints[0]
				areas[areaFor] += 1

				// mark any coordinate that has an infinite area
				if (i == l || i == r || j == t || j == b) {
					for _, c := range closestPoints {
						infinite[c] = true
					}
				}
			}
		}
	}

	maxArea := 0
	for coord, area := range areas {
		if _, ok := infinite[coord]; !ok {
			if area > maxArea {
				maxArea = area
			}
		}
	}

	return maxArea
}

func findBounds(coords [][]int) (l, r, t, b int) {
	l, t = 100000, 100000

	for _, c := range coords {
		x, y := c[0], c[1]
		if x < l {
			l = x
		}
		if y < t {
			t = y
		}
		if x > r {
			r = x
		}
		if y > b {
			b = y
		}
	}

	return
}

func distance(pt1, pt2 []int) int {
	x1, y1 := float64(pt1[0]), float64(pt1[1])
	x2, y2 := float64(pt2[0]), float64(pt2[1])
	dist := int(math.Abs(x1-x2) + math.Abs(y1-y2))

	return dist
}

func findClosest(pt []int, coords [][]int) (pts []int) {
	min := 100000
	distances := make(map[int][]int)
	// {
	// 	dist := []int{indexes}
	// }
	for i, pt2 := range coords {
		dist := distance(pt, pt2)
		if dist < min {
			min = dist
		}

		if _, ok := distances[dist]; !ok {
			distances[dist] = []int{}
		}
		distances[dist] = append(distances[dist], i)
	}

	return distances[min]
}

func main() {
	input, err := ioutil.ReadFile("../../inputs/day6.in")
	if err != nil {
		panic(err)
	}
	coords := formatInput(string(input))
	part1, part2 := FindLargestArea(coords)
	fmt.Printf("Day 6 Part 1: %+v\n", part1)
	fmt.Printf("Day 6 Part 2: %+v\n", part2)
}

func formatInput(input string) (coords [][]int) {
	input = strings.TrimSpace(string(input))
	lines := strings.Split(input, "\n")

	for _, line := range lines {
		var x, y int
		fmt.Sscanf(line, "%d, %d", &x, &y)
		coord := []int{x, y}
		coords = append(coords, coord)
	}

	return
}
