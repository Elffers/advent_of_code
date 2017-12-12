package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

func haveSeen(val string, seen []string) bool {
	for _, s := range seen {
		if s == val {
			return true
		}
	}
	return false
}

func groupFor(val string, programs map[string][]string) (seen []string) {
	queue := []string{val}

	for len(queue) > 0 {
		val = queue[0]
		queue = queue[1:]

		if haveSeen(val, seen) {
			continue
		}
		seen = append(seen, val)
		queue = append(queue, programs[val]...)
	}

	return seen
}

func difference(slice1 []string, slice2 []string) []string {
    diff := []string{}
    m := map [string]int{}

    for _, s1Val := range slice1 {
        m[s1Val] = 1
    }
    for _, s2Val := range slice2 {
        m[s2Val] = m[s2Val] + 1
    }

    for mKey, mVal := range m {
        if mVal==1 {
            diff = append(diff, mKey)
        }
    }

    return diff
}

func main() {
	input, err := ioutil.ReadFile("../../day12.in")

	if err == nil {
		input := strings.TrimSpace(string(input))
		programs := strings.Split(input, "\n")
		graph := make(map[string][]string)

		for _, program := range programs {
			entry := strings.Split(program, " <-> ")
			key := entry[0]
			value := strings.Split(entry[1], ", ")
			graph[key] = value
		}

		seen := groupFor("0", graph)
		fmt.Println(len(seen))

		// keys of graph
		keys := make([]string, 0, len(graph))
		for k := range graph {
			keys = append(keys, k)
		}

		groups := 0

		for len(keys) > 0 {
			val := keys[0]
			seen := groupFor(val, graph)
			keys = difference(keys, seen)
			groups += 1
		}

		fmt.Println(groups)
	}
}
