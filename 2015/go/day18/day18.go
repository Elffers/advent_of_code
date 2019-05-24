package main

import (
	"fmt"
	"io/ioutil"
	"strings"
)

type Grid struct {
	Rows [][]bool
	Size int
}

func NewGrid(in []string) Grid {
	rows := make([][]bool, len(in))

	for i, line := range in {
		row := make([]bool, len(line))
		for j, b := range []byte(line) {
			if string(b) == "#" {
				row[j] = true
			} else {
				row[j] = false
			}
		}
		rows[i] = row
	}
	return Grid{Rows: rows, Size: len(in)}
}

func (g Grid) LitNeighborsCount(i, j int) int {
	count := 0

	neighbors := [][]int{
		[]int{i-1, j-1},
		[]int{i-1, j},
		[]int{i-1, j+1},
		[]int{i, j-1},
		[]int{i, j+1},
		[]int{i+1, j-1},
		[]int{i+1, j},
		[]int{i+1, j+1},
	}

	for _, n := range neighbors {
		if g.InBounds(n) && g.IsLit(n){
			count += 1
		}
	}
	return count
}

func (g Grid) InBounds(point []int) bool {
	x, y := point[0], point[1]
	return x < g.Size && x >= 0 && y < g.Size && y >= 0
}

func (g Grid) IsLit(point []int) bool {
	x, y := point[0], point[1]
	return g.Rows[x][y]
}

func (g *Grid) LightCorners() {
	max := g.Size - 1
	g.Rows[0][0] = true
	g.Rows[0][max] = true
	g.Rows[max][0] = true
	g.Rows[max][max] = true
}

func (g Grid) Change(lightCorners bool) Grid {
	newRows := make([][]bool, len(g.Rows))
	for i, row := range g.Rows {
		newRow := make([]bool, len(row))
		for j, light := range row {
			lit := g.LitNeighborsCount(i,j)
			if light { // A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
				if lit == 2 || lit == 3 {
					newRow[j] = true
				} else {
					newRow[j] = false
				}

			} else { // A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
				if lit == 3 {
					newRow[j] = true
				} else {
					newRow[j] = false
				}
			}
		}
		newRows[i] = newRow
	}

	grid := Grid{Rows: newRows, Size: len(g.Rows)}

	if lightCorners {
		grid.LightCorners()
	}

	return grid
}

func (g Grid) CountLit() int {
	count := 0
	for _, row := range g.Rows {
		for _, light := range row {
			if light {
				count += 1
			}
		}
	}

	return count
}

func main() {
	in, err := ioutil.ReadFile("./day18.in")
	if err == nil {
		input := strings.TrimSpace(string(in))
		rows := strings.Split(string(input), "\n")
		grid := NewGrid(rows)

		for n := 0; n < 100; n++ {
			grid = grid.Change(true)
		}

		fmt.Printf("Day 1 Part 1: %+v\n", grid.CountLit())
	}
}
