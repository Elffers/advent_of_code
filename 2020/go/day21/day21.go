package main

import(
	"os"
)

func main() {
	file, err := os.Open("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day21.in")
	if err != nil {
		panic(err)
	}
	defer file.Close()
}
