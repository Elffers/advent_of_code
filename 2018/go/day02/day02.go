package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func Checksum(ids []string) int {
	twos, threes := 0, 0
	for _, id := range ids {
		// store character counts
		count := make(map[rune]int)
		for _, char := range id {
			count[char]++
		}

		occurences := make(map[int]bool)
		for _, val := range count {
			occurences[val] = true
		}

		if occurences[2] {
			twos++
		}
		if occurences[3] {
			threes++
		}

	}
	return twos * threes
}

func HamOne(ids []string) string {
	for i, id := range ids {
		for j, id2 := range ids {
			diff := 0
			letters := ""

			if j <= i {
				continue
			}

			if len(id) == len(id2) {
				for idx, char := range id {
					if string(char) != string(id2[idx]) {
						diff++
					} else {
						letters += string(char)
					}
				}

			}

			if diff == 1 {
				return letters
			}
		}

	}

	return ""
}


func main() {
	test_ids := []string{
		"abcdef",
		"bababc",
		"abbcde",
		"abcccd",
		"aabcdd",
		"abcdee",
		"ababab",
	}
	fmt.Printf("Test: Expect 12, Got: %+v\n", Checksum(test_ids))

	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day2.in")
	if err != nil {
		panic(err)
	}
	ids := formatInput(string(input))

	fmt.Printf("Day 2 Part 1: %+v\n", Checksum(ids))
	fmt.Printf("Day 2 Part 2: %+v\n", HamOne(ids))
}

func formatInput(input string) []string{
	return strings.Split(input, "\n")
}
