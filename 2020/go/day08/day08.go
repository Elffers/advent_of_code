package main

import(
	"fmt"
	"io/ioutil"
	"strconv"
	"strings"
)

func find_loop(input []string) (acc int, halts bool) {
	pc := 0
	seen := make(map[int]int)

	for {
		seen[pc] += 1

		if seen[pc] == 2 {
			return acc, false
		}

		if pc == len(input)-1 {
			return acc, true
		}

		line := input[pc]
		split := strings.Split(line, " ")
		instr := split[0]
		arg, _ := strconv.Atoi(split[1])

		switch instr {
			case "acc":
				acc += arg
				pc += 1
			case "jmp":
				pc += arg
			case "nop":
				pc += 1
		}
	}
}

func main() {
	file, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day08.in")
	if err != nil {
		panic(err)
	}
	input := strings.Split(string(file), "\n")

	acc, _ := find_loop(input)
	fmt.Printf("part 1: %d\n", acc)

	for i, line := range input {
		fixed := make([]string, len(input))
		copy(fixed, input)

		split := strings.Split(line, " ")
		instr := split[0]
		arg := split[1]

		switch instr {
			case "nop":
				fixed[i] = fmt.Sprintf("jmp %s", arg)
			case "jmp":
				fixed[i] = fmt.Sprintf("nop %s", arg)
		}
		acc, halts := find_loop(fixed)
		if halts {
			fmt.Printf("part 2: %d\n", acc)
			break
		}
	}
}
