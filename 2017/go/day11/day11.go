package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"math"
)

func distance(x int, y int) int {
	xSign := x > 0
	ySign := y > 0
	a := math.Abs(float64(x))
	b := math.Abs(float64(y))

	if xSign == ySign {
		return int(math.Max(a,b))
	}

	return int(a + b)
}

func main() {
	input, err := ioutil.ReadFile("../../day11.in")

	if err == nil {
		input := strings.TrimSpace(string(input))
		dirs := strings.Split(input, ",")

		x, y := 0, 0
		max := 0

		for _, dir := range dirs {
			switch dir {
			case "ne":
				y += 1
			case "sw":
				y -= 1
			case "nw":
				x += 1
			case "se":
				x -= 1
			case "n":
				y +=1
				x += 1
			case "s":
				y -=1
				x -= 1
			}

			if dist := distance(x,y); dist > max {
				max = dist
			}
		}

		fmt.Println(distance(x, y))
		fmt.Println(max)
	}
}
