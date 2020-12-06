package main

import(
	"fmt"
	"io/ioutil"
	"strings"
)

// this is the worst
// func splitGroups (data []byte, atEOF bool) (advance int, token []byte, err error) {
// 	if atEOF && len(data) == 0 {
// 		return 0, nil, nil
// 	}
// 	if i := strings.Index(string(data), "\n\n"); i >= 0 {
// 		return i + 1, data[0:i], nil
// 	}
// 	// If we're at EOF, we have a final, non-terminated line. Return it.
// 	if atEOF {
// 		return len(data), data, nil
// 	}
// 	// Request more data.
// 	return 0, nil, nil
// }

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2020/inputs/day04.in")
	if err != nil {
		panic(err)
	}

	passports := strings.Split(string(input), "\n\n")
	// scanner.Split(splitGroups)
	r := strings.NewReplacer("\n", " ")

	valid := 0
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
			valid += 1
		}
		if len(data) == 7 {
			if _, ok := data["cid"]; !ok {
				valid += 1
			}
		}
	}
	fmt.Printf("part 1: %d\n", valid)
}
