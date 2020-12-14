package main

import(
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func contains_shiny_gold(key string, graph map[string]map[string]int) bool {
	queue := []string{}
	for bag, _ := range graph[key] {
		queue = append(queue, bag)
	}

	for len(queue) > 0 {
		key := queue[0]
		queue = queue[1:len(queue)]

		if key == "shiny gold" {
			return true
		}

		for bag, _ := range graph[key] {
			queue = append(queue, bag)
		}
	}
	return false
}
func total_bags_for(key string, graph map[string]map[string]int) int {
	inner_bags := graph[key]
	if len(inner_bags) == 0 {
		return 0
	}
	total := 0
	for bag, count := range inner_bags {
		total += count * total_bags_for(bag, graph) + count
	}
	return total
}

func main() {
	file, err := os.Open("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day07.in")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	// create graph of bags
	bags := make(map[string]map[string]int)

	kre := regexp.MustCompile(`^(\w+ \w+)`)
	vre := regexp.MustCompile(`(\d+) (\w+ \w+) bag`)

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		split := strings.Split(line, "contain")
		key, vals := split[0], split[1]

		outer_bag := kre.FindString(key)

		inner_bags := make(map[string]int)
		inner := strings.Split(vals, ",")
		for _, bag := range inner {
			// should return a slice with 1 matched element
			match := vre.FindAllStringSubmatch(bag, -1)
			if match != nil {
				res := match[0]
				n, _ := strconv.Atoi(res[1])
				ib  := res[2]
				inner_bags[ib] = n
			}
		}

		bags[outer_bag] = inner_bags
	}

	count := 0
	for outer, _ := range bags {
		if contains_shiny_gold(outer, bags) {
			count += 1
		}
	}

	fmt.Printf("part 1: %d\n", count)
	fmt.Printf("part 2: %d\n",total_bags_for("shiny gold", bags))
}
