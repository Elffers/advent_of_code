package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"sort"
)

func hasDupes(words []string) bool {
	seen := map[string]bool{}
	uniques := []string{}

	for _, word := range words {
		if seen[word] == false {
			seen[word] = true
			uniques = append(uniques, word)
		}
	}

	return len(words) != len(uniques)
}

func hasAnagrams(words []string) bool {
	seen := map[string]bool{}
	uniques := []string{}

	for _, word := range words {
		sorted := sortString(word)
		if seen[sorted] == false {
			seen[sorted] = true
			uniques = append(uniques, word)
		}
	}

	return len(words) != len(uniques)
}

func sortString(word string) string {
	chars := []string{}
	for _, b := range word {
		chars = append(chars, string(b))
	}
	sort.Strings(chars)

	return strings.Join(chars, "")
}

func main() {
	input, err := ioutil.ReadFile("day4.in")
	if err == nil {
		list := strings.TrimSpace(string(input))
		phrases := strings.Split(list, "\n")

		count, count2 := 0, 0
		for _, phrase := range phrases {
			phrase = strings.TrimSpace(phrase)
			words := strings.Split(phrase, " ")
			if hasDupes(words) == false {
				count += 1
			}
			if hasAnagrams(words) == false {
				count2 += 1
			}
		}

		fmt.Printf("Part 1: %v\nPart 2: %v\n", count, count2)
	}
}
