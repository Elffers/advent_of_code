package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"strconv"
	"strings"
)

// ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
func valid(data map[string]string) bool {
	if val, ok := data["byr"]; ok {
		y, _ := strconv.Atoi(val)
		if (y < 1920) || (y > 2002) {
			return false
		}
	}

	if val, ok := data["iyr"]; ok {
		y, _ := strconv.Atoi(val)
		if (y < 2010) || (y > 2020) {
			return false
		}
	}

	if val, ok := data["eyr"]; ok {
		y, _ := strconv.Atoi(val)
		if (y < 2020) || (y > 2030) {
			return false
		}
	}

	if val, ok := data["hgt"]; ok {
		unit := val[len(val)-2 : len(val)]
		height := val[:len(val)-2]
		h, _ := strconv.Atoi(height)
		switch unit {
		case "cm":
			if (h < 150) || (h > 193) {
				return false
			}
		case "in":
			if (h < 59) || (h > 76) {
				return false
			}
		default:
			return false
		}
	}

	if val, ok := data["hcl"]; ok {
		re := regexp.MustCompile(`^#[0-9a-f]{6}$`)
		match := re.MatchString(val)
		if !match {
			return false
		}
	}

	if val, ok := data["ecl"]; ok {
		re := regexp.MustCompile(`^(amb|blu|brn|gry|grn|hzl|oth)$`)
		match := re.MatchString(val)
		if !match {
			return false
		}
	}
	if val, ok := data["pid"]; ok {
		re := regexp.MustCompile(`^[0-9]{9}$`)
		match := re.MatchString(val)
		if !match {
			return false
		}
	}

	return true
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day04.in")
	if err != nil {
		panic(err)
	}

	passports := strings.Split(string(input), "\n\n")
	r := strings.NewReplacer("\n", " ")

	valid1, valid2 := 0, 0
	for _, p := range passports {

		passpt := r.Replace(p)
		data := make(map[string]string)

		fields := strings.Split(passpt, " ")
		for _, f := range fields {
			if len(f) != 0 {
				field := strings.Split(f, ":")
				data[field[0]] = field[1]
			}
		}
		if len(data) == 8 {
			valid1 += 1
			if valid(data) {
				valid2 += 1
			}
		}
		if len(data) == 7 {
			if _, ok := data["cid"]; !ok {
				valid1 += 1

				if valid(data) {
					valid2 += 1
				}
			}
		}
	}
	fmt.Printf("part 1: %d\n", valid1)
	fmt.Printf("part 2: %d\n", valid2)
}
