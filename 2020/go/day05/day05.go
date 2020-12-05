package main

import(
	"fmt"
	"os"
	"bufio"
	"strconv"
	"sort"
	"strings"
)

func main() {
	file, err := os.Open("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day05.in")
	if err != nil {
		panic(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	seats := []string{} // binary rep of seats
	r := strings.NewReplacer("F", "0", "B", "1", "L", "0", "R", "1")

	for scanner.Scan() {
		line := scanner.Text()
		b := r.Replace(line)
		seats = append(seats, b)
	}
	sort.Strings(seats)
	max, _ := strconv.ParseInt(seats[len(seats)-1], 2, 11)
	fmt.Printf("part 1: %d\n", max)

	// Part 2
	offset, _ := strconv.ParseInt(seats[0], 2, 11)
	for i, s := range seats {
		seat, _ := strconv.ParseInt(s, 2, 11)
		if seat != int64(i) + offset {
			fmt.Printf("part 1: %d\n", seat - 1)
			break
		}
	}
}
