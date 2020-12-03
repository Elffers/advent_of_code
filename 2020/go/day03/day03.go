package main

import(
	"fmt"
	"io/ioutil"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day03.in")
	if err != nil {
		panic(err)
	}
	rows := strings.Split(string(input), "\n")
	rows = rows[:len(rows)-1] // for whatever reason there is an extra newline at the end

	x1 := 0
	t1 := 0 // right 3, down 1

	x2 := 0
	t2 := 0 // Right 1, down 1.

	x3 := 0
	t3 := 0 // Right 5, down 1.

	x4 := 0
	t4 := 0 // Right 7, down 1.

	x5 := 0
	t5 := 0 // Right 1, down 2.

	for i, row := range rows {
		if i == 0 {
			continue
		}

		x1 += 3
		i1 := x1%len(row)
		if (string(row[i1]) == "#") {
			t1 += 1
		}

		x2 += 1
		i2 := x2%len(row)
		if (string(row[i2]) == "#") {
			t2 += 1
		}

		x3 += 5
		i3 := x3%len(row)
		if (string(row[i3]) == "#") {
			t3 += 1
		}

		x4 += 7
		i4 := x4%len(row)
		if (string(row[i4]) == "#") {
			t4 += 1
		}

		if i % 2 == 0 {
			x5 += 1
			i5 := x5%len(row)
			if (string(row[i5]) == "#") {
				t5 += 1
			}
		}
	}

	fmt.Printf("Part 1: %d\n", t1)
	fmt.Printf("Part 2: %d", t1*t2*t3*t4*t5)
}
