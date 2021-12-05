package main

import(
	"bufio"
	"os"
	"fmt"
	"strings"
	"strconv"
)

func main() {
	file, err := os.Open("/Users/hhh/JungleGym/advent_of_code/2021/inputs/day02.in")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	s := bufio.NewScanner(file)
	x, y := 0,0
	x2, y2, a := 0,0,0
	for s.Scan() {
		res := strings.Split(s.Text(), " ")
		dir := res[0]
		d, _ := strconv.Atoi(res[1])
		switch dir {
			case "forward":
				x += d
				x2 += d
				y2 += a*d
			case "down":
				y += d
				a += d
			case "up":
				y -= d
				a -= d
		}
	}
	fmt.Printf("Day 1: %d\n", x*y)
	fmt.Printf("Day 1: %d\n", x2*y2)
}
