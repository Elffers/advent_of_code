package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func charcount(char, pwd string) (count int) {
	for _, c := range pwd {
		if string(c) == char {
			count += 1
		}
	}
	return
}

func main() {
	file, err := os.Open("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day02.in")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	validPwd := regexp.MustCompile(`(\d+)-(\d+) (\w): (\w+)`)
	scanner := bufio.NewScanner(file)
	p1, p2 := 0, 0

	for scanner.Scan() {
		line := scanner.Text()
		res := validPwd.FindAllStringSubmatch(line, -1)[0]
		min, _ := strconv.Atoi(string(res[1]))
		max, _ := strconv.Atoi(string(res[2]))
		char := res[3]
		pwd := res[4]

		// Part 1
		count := charcount(char, pwd)

		if count >= min && count <= max {
			p1 += 1
		}

		// Part 2
		c1 := string(pwd[min-1])
		c2 := string(pwd[max-1])
		if (c1 == char) && (c2 != char) {
			p2 += 1
		}
		if (c1 != char) && (c2 == char) {
			p2 += 1
		}

	}
	fmt.Printf("Day 1: %d\n", p1)
	fmt.Printf("Day 2: %d", p2)
}
