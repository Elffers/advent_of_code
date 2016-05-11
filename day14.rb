require 'pry'
# --- Day 14: Reindeer Olympics ---

# This year is the Reindeer Olympics! Reindeer can fly at high speeds, but
# must rest occasionally to recover their energy. Santa would like to know
# which of his reindeer is fastest, and so he has them race.

# Reindeer can only either be flying (always at their top speed) or resting
# (not moving at all), and always spend whole seconds in either state.

# For example, suppose you have the following Reindeer:

# Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
# Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
# After one second, Comet has gone 14 km, while Dancer has gone 16 km. After
# ten seconds, Comet has gone 140 km, while Dancer has gone 160 km. On the
# eleventh second, Comet begins resting (staying at 140 km), and Dancer
# continues on for a total distance of 176 km. On the 12th second, both
# reindeer are resting. They continue to rest until the 138th second, when
# Comet flies for another ten seconds. On the 174th second, Dancer flies for
# another 11 seconds.

# In this example, after the 1000th second, both reindeer are resting, and
# Comet is in the lead at 1120 km (poor Dancer has only gotten 1056 km by that
# point). So, in this situation, Comet would win (if the race ended at 1000
# seconds).

# Given the descriptions of each reindeer (in your puzzle input), after
# exactly 2503 seconds, what distance has the winning reindeer traveled?

class Racer
  attr_accessor :reindeer

  def initialize input
    @input = input.map { |line| line.strip! }
    @reindeer = Hash.new { |h, k| h[k] = {} }
  end

  def parse
    @input.each do |line|
      /^(?<name>\w+) \D+(?<speed>\d+) \D+(?<time>\d+) \D+(?<rest>\d+)/ =~ line
      reindeer[name][:speed] = speed.to_i
      reindeer[name][:interval] = time.to_i
      reindeer[name][:rest] = rest.to_i
    end
  end

  def distance time, name
    speed = reindeer[name][:speed]
    interval = reindeer[name][:interval]
    rest = reindeer[name][:rest]

    reps, partial = time.divmod(interval + rest)
    if partial < interval
      distance = reps * speed * interval + speed * partial
    else
      distance = (reps + 1) * speed * interval
    end

    distance
  end

  def race time
    reindeer.keys.map do |deer|
      distance time, deer
    end.max
  end
end



if __FILE__ == $0
  input = File.readlines("day14_input.txt")
  racer = Racer.new input
  racer.parse
  p racer.race 2503
end
