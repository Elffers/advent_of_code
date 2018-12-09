# --- Day 21: RPG Simulator 20XX ---

# Little Henry Case got a new video game for Christmas. It's an RPG, and he's stuck on a boss. He needs to know what equipment to buy at the shop. He hands you the controller.

# In this game, the player (you) and the enemy (the boss) take turns attacking. The player always goes first. Each attack reduces the opponent's hit points by at least 1. The first character at or below 0 hit points loses.

# Damage dealt by an attacker each turn is equal to the attacker's damage score minus the defender's armor score. An attacker always does at least 1 damage. So, if the attacker has a damage score of 8, and the defender has an armor score of 3, the defender loses 5 hit points. If the defender had an armor score of 300, the defender would still lose 1 hit point.

# Your damage score and armor score both start at zero. They can be increased by buying items in exchange for gold. You start with no items and have as much gold as you need. Your total damage or armor is equal to the sum of those stats from all of your items. You have 100 hit points.

# Here is what the item shop is selling:

# Weapons:    Cost  Damage  Armor
# Dagger        8     4       0
# Shortsword   10     5       0
# Warhammer    25     6       0
# Longsword    40     7       0
# Greataxe     74     8       0

# Armor:      Cost  Damage  Armor
# Leather      13     0       1
# Chainmail    31     0       2
# Splintmail   53     0       3
# Bandedmail   75     0       4
# Platemail   102     0       5

# Rings:      Cost  Damage  Armor
# Damage +1    25     1       0
# Damage +2    50     2       0
# Damage +3   100     3       0
# Defense +1   20     0       1
# Defense +2   40     0       2
# Defense +3   80     0       3
# You must buy exactly one weapon; no dual-wielding. Armor is optional, but you can't use more than one. You can buy 0-2 rings (at most one for each hand). You must use any items you buy. The shop only has one of each item, so you can't buy, for example, two rings of Damage +3.

# For example, suppose you have 8 hit points, 5 damage, and 5 armor, and that the boss has 12 hit points, 7 damage, and 2 armor:

# The player deals 5-2 = 3 damage; the boss goes down to 9 hit points.
# The boss deals 7-5 = 2 damage; the player goes down to 6 hit points.
# The player deals 5-2 = 3 damage; the boss goes down to 6 hit points.
# The boss deals 7-5 = 2 damage; the player goes down to 4 hit points.
# The player deals 5-2 = 3 damage; the boss goes down to 3 hit points.
# The boss deals 7-5 = 2 damage; the player goes down to 2 hit points.
# The player deals 5-2 = 3 damage; the boss goes down to 0 hit points.
# In this scenario, the player wins! (Barely.)

# You have 100 hit points. The boss's actual stats are in your puzzle input. What is the least amount of gold you can spend and still win the fight?

class Player
  attr_accessor :points, :damage, :armor, :name, :spent

  def initialize(points:, damage:, armor:, name:)
    @points = points
    @damage = damage
    @armor = armor
    @name = name
    @spent = 0
  end

  def attack(opponent)
    damage = @damage - opponent.armor
    if damage > 0
      opponent.points -= damage
    else
      opponent.points -= 1
    end
  end

  def buy(item)
    self.damage += item.damage
    self.armor += item.armor
    self.spent += item.cost
  end
end

class Item
  attr_accessor :cost, :damage, :armor, :name

  def initialize(cost:, damage:, armor:, name:)
    @cost = cost
    @damage = damage
    @armor = armor
    @name = name
  end
end

WEAPONS = [
  Item.new(cost: 8,  damage: 4, armor: 0, name: "dagger"),
  Item.new(cost: 10, damage: 5, armor: 0, name: "shortsword"),
  Item.new(cost: 25, damage: 6, armor: 0, name: "warhammer"),
  Item.new(cost: 40, damage: 7, armor: 0, name: "longsword"),
  Item.new(cost: 74, damage: 8, armor: 0, name: "greataxe"),
]

ARMOR = [
  Item.new(cost: 13,  damage: 0, armor: 1, name: "leather"),
  Item.new(cost: 31,  damage: 0, armor: 2, name: "chainmail"),
  Item.new(cost: 53,  damage: 0, armor: 3, name: "splintmail"),
  Item.new(cost: 75,  damage: 0, armor: 4, name: "bandedmail"),
  Item.new(cost: 102, damage: 0, armor: 5, name: "platemail"),
]

RINGS = [
  Item.new(cost: 25,  damage: 1, armor: 0, name: "damage1"),
  Item.new(cost: 50,  damage: 2, armor: 0, name: "damage2"),
  Item.new(cost: 100, damage: 3, armor: 0, name: "damage3"),
  Item.new(cost: 20,  damage: 0, armor: 1, name: "defense1"),
  Item.new(cost: 40,  damage: 0, armor: 2, name: "defense2"),
  Item.new(cost: 80,  damage: 0, armor: 3, name: "defense3"),
]

def play(player, enemy)
  loop do
    player.attack enemy
    if enemy.points < 1
      return player.name, player.spent
    end

    enemy.attack player
    if player.points < 1
      return "FAIL"
    end
  end
end

ring_combos = []
RINGS.combination(0).each do |rc|
  ring_combos.push rc
end
RINGS.combination(1).each do |rc|
  ring_combos.push rc
end
RINGS.combination(2).each do |rc|
  ring_combos.push rc
end
armor_combos = []
ARMOR.combination(0).each do |a|
  armor_combos.push a
end
ARMOR.combination(1).each do |a|
  armor_combos.push a
end

item_combos = []

WEAPONS.each do |weapon|
  ring_combos.each do |rc|
    armor_combos.each do |a|
      combo = []
      combo << a
      combo << rc
      combo << weapon
      item_combos.push combo.flatten
    end
  end
end

win_costs= []
fail_costs = []

item_combos.each do |items|
  me = Player.new(
    points: 100,
    damage: 0,
    armor: 0,
    name: "me"
  )
  boss = Player.new(
    points: 104,
    damage: 8,
    armor: 1,
    name: "boss"
  )

  items.each do |i|
    me.buy i
  end

  res = play(me, boss)
  if res != "FAIL"
    win_costs << me.spent
  else
    fail_costs << me.spent
  end
end

p "Part 1: #{win_costs.min}"
p "Part 2: #{fail_costs.max}"
