package main

import (
	"fmt"
	"io/ioutil"
	"strings"
	"strconv"
)

func exec(instr string, registers map[string]int) map[string]int {
	split := strings.Split(instr, " ")
	reg := split[0]
	op := split[1]
	val, _ := strconv.Atoi(split[2])

	if op == "inc" {
		registers[reg] += val
	} else {
		registers[reg] -= val
	}

	return registers
}

func isTrue(cond string, registers map[string]int) bool {
	split := strings.Split(cond, " ")
	reg := split[0]
	op := split[1]
	val, _ := strconv.Atoi(split[2])

	switch op {
	case "==":
		return registers[reg] == val
	case "!=":
		return registers[reg] != val
	case "<=":
		return registers[reg] <= val
	case ">=":
		return registers[reg] >= val
	case "<":
		return registers[reg] < val
	case ">":
		return registers[reg] > val
	}

	return false
}

func maxRegister(registers map[string]int) int {
	max := 0
	for _, val := range registers {
		if val > max {
			max = val
		}
	}
	return max
}

func main() {
	input, err := ioutil.ReadFile("day8.in")

	if err == nil {
		registers := make(map[string]int)
		input := strings.TrimSpace(string(input))
		lines := strings.Split(input, "\n")

		localMax := 0
		for _, line := range lines {
			split := strings.Split(line, " if ")
			instr := split[0]
			cond := split[1]

			if isTrue(cond, registers) {
				registers = exec(instr, registers)

				local := maxRegister(registers)
				if local > localMax {
					localMax = local
				}
			}

		}

		max := maxRegister(registers)
		fmt.Printf("max: %v\n", max)
		fmt.Printf("local max: %v\n", localMax)
	}
}
