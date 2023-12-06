require 'set'
input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day11.in").split("\n\n")

class Monkey
  attr_accessor :id, :items, :operation, :test, :m1, :m2

  def initialize id, items, operation, div, m1, m2
    @id = id
    @items = items
    @op = parse_op operation
    @test = Proc.new { |x| x % div == 0 }
    @m1 = m1
    @m2 = m2
  end

  def parse_op operation
    _, op, y = operation.split(" ")
    Proc.new do |item|
      n =  y == "old" ? item : y.to_i
      item.send(op.to_sym, n)
    end
  end

  def sniff item, lcm, pt1=false
    level = @op.call item
    if pt1
      level/3
    else
      level % lcm # leverage Chinese Remainder Theorem
    end
  end

  def throw_to item
    test.call(item) ? m1 : m2
  end
end

def observe monkeys, count, lcm, pt1
  monkeys.each do |monkey|
    while !monkey.items.empty?
      i = monkey.items.shift
      count[monkey.id] += 1
      level = monkey.sniff i, lcm, pt1
      id = monkey.throw_to level
      monkeys[id.to_i].items << level
    end
  end
end

def load_monkeys input
  monkeys = []
  lcm = 1

  input.each do |m|
    /Monkey (?<id>\d+)/ =~ m
    /Starting items: (?<items>.+)/ =~ m
    /Operation: new = (?<operation>.+ . .+)/ =~ m
    /Test: divisible by (?<div>\d+)/ =~ m
    /If true: throw to monkey (?<m1>\d+)/ =~m
    /If false: throw to monkey (?<m2>\d+)/ =~m

    items = items.split(",").map { |x| x.to_i }
    div = div.to_i
    lcm *= div

    monkey = Monkey.new(id, items, operation, div, m1, m2)
    monkeys << monkey
  end
  [monkeys, lcm]
end

count = Hash.new 0
monkeys, lcm = load_monkeys input

20.times do |i|
  monkeys = observe monkeys, count, lcm, true
end
p "Part 1: #{count.values.sort[-2..-1].reduce(:*)}"

count = Hash.new 0
monkeys, lcm = load_monkeys input

10000.times do |i|
  monkeys = observe monkeys, count, lcm, false
end
p "Part 2: #{count.values.sort[-2..-1].reduce(:*)}"
