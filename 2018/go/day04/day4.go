package main

import (
	"fmt"
	"io/ioutil"
	"regexp"
	"sort"
	"strings"
	"time"
)

// Populate map with sleep schedule per guard by tallying times guard was
// asleep in a given minute
func GuardSchedule(logs []LogEntry) map[int]map[int]int {
	guards := make(map[int]map[int]int)
	guard, sleepAt := 0, 0

	for _, log := range logs {
		if strings.Contains(log.Event, "Guard") {
			var id int
			fmt.Sscanf(log.Event, "Guard #%d begins shift", &id)
			guard = id
			if _, ok := guards[guard]; !ok {
				guards[guard] = make(map[int]int)
			}
		}

		if log.Event == "falls asleep" {
			sleepAt = log.Time.Minute()
		}

		if log.Event == "wakes up" {
			now := log.Time.Minute()
			for min := sleepAt; min < now; min++ {
				guards[guard][min]++
			}
		}
	}

	return guards
}

func FindSleepiest(logs []LogEntry) int {
	totals := make(map[int]int) // guard id : total minutes
	schedule := GuardSchedule(logs)

	// Accumulate total number of minutes asleep per guard
	for id, log := range schedule {
		for _, count := range log {
			totals[id] += count
		}
	}

	// Find guard who slept the most total minutes
	sleepiest, max := 0, 0
	for id, total := range totals {
		if total > max {
			sleepiest = id
			max = total
		}
	}

	// Find which minute said guard was most often asleep
	sleepiestMin, _ := sleepiestMinute(schedule[sleepiest])

	return sleepiest * sleepiestMin
}

func sleepiestMinute(log map[int]int) (minute, count int) {
	sleepiestMin, maxCount := 0, 0
	for min, count := range log {
		if count > maxCount {
			sleepiestMin = min
			maxCount = count
		}
	}
	return sleepiestMin, maxCount
}

func FindMostPredictablySleepy(logs []LogEntry) int {
	mostFrequentlyAsleep := make(map[int][]int) // guard: [minute, count]
	schedule := GuardSchedule(logs)

	// Find minute each guard was most often asleep
	for id, log := range schedule {
		min, count := sleepiestMinute(log)
		mostFrequentlyAsleep[id] = []int{min, count}
	}
	// Find which guard fell asleep most often at a given minute
	guard, minute, count := 0, 0, 0
	for id, minuteCount := range mostFrequentlyAsleep {
		m := minuteCount[0]
		c := minuteCount[1]
		if c > count {
			guard = id
			minute = m
			count = c
		}
	}

	return guard * minute
}

func main() {
	input, err := ioutil.ReadFile("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day4.in")
	if err != nil {
		panic(err)
	}
	logs := formatInput(string(input))
	sort.Sort(ByTime(logs))
	fmt.Printf("Day 4 Part 1: %+v\n", FindSleepiest(logs))
	fmt.Printf("Day 4 Part 2: %+v\n", FindMostPredictablySleepy(logs))
}

func formatInput(input string) []LogEntry {
	lines := strings.Split(input, "\n")
	logs := []LogEntry{}

	for _, line := range lines {
		if line != "" {
			r, _ := regexp.Compile(`\[(?P<timestamp>.+)\] (?P<event>.+)`)
			match := r.FindStringSubmatch(line)
			event := match[2]
			timestamp := match[1]
			ts, _ := time.Parse("2006-01-02 15:04", timestamp)
			logs = append(logs, LogEntry{ts, event})
		}
	}
	return logs
}

type LogEntry struct {
	Time  time.Time
	Event string
}

type ByTime []LogEntry

func (logs ByTime) Len() int           { return len(logs) }
func (logs ByTime) Swap(i, j int)      { logs[i], logs[j] = logs[j], logs[i] }
func (logs ByTime) Less(i, j int) bool { return logs[i].Time.Unix() < logs[j].Time.Unix() }
