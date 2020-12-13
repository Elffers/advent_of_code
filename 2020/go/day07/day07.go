package main

import(
	"io/ioutil"
	"strings"
)

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day07.in")
	if err != nil {
		panic(err)
	}
	strings.Split(string(input), "\n")

}
