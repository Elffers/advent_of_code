require 'time'
require 'pp'

log = {}
File.readlines("/Users/hhh/JungleGym/advent_of_code/2018/inputs/day4.in").each do |line|
  /(?<timestamp>\[.+\]) (?<dir>.+)/ =~ line
  time = Time.parse timestamp
  log[time] = dir
end

log = log.sort_by { |time, action| time }

guards = Hash.new { |h, k| h[k] = Hash.new 0 }

start_sleep = 0
current_guard = 0

log.each do |timestamp, dir|
  if dir.include? "Guard"
    /(?<guard>\d+)/ =~ dir
    current_guard = guard.to_i
  end

  if dir ==  "falls asleep"
    start_sleep = timestamp.min
  end

  if dir ==  "wakes up"
    now = timestamp.min
    (start_sleep...now).each do |min|
      guards[current_guard][min] += 1
    end
  end
end

# Total time asleep per guard
# guard => total time asleep
totals = {}

guards.each do |guard, log|
  totals[guard] = log.values.reduce(:+)
end

sleepiest, time_asleep = totals.max_by { |k, v| v}
minute, count = guards[sleepiest].max_by { |min, count | count }

p "Part 1: #{sleepiest * minute}"

# Part 2

# Store which minute each guard is most often asleep
# guard => [minute, count]
most_often_asleep = {}

guards.each do |guard, log|
  log_entry = log.max_by { |min, count| count }
  most_often_asleep[guard] = log_entry
end

guard, log_entry = most_often_asleep.max_by { |g, entry| entry.last } # max by count
p "Part 2: #{guard * log_entry.first}"
