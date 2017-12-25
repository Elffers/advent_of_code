states = {
  "A" => {
    0 => { :next_state => "B", :dir => 1,  val: 1 },
    1 => { :next_state => "E", :dir => -1, val: 0 }
  },
  "B" => {
    0 => { :next_state => "C", :dir => -1, val: 1 },
    1 => { :next_state => "A", :dir => 1, val: 0 }
  },
  "C" => {
    0 => { :next_state => "D", :dir => -1, val: 1 },
    1 => { :next_state => "C", :dir => 1,  val: 0 },
  },
  "D" => {
    0 => { :next_state => "E", :dir => -1, val: 1 },
    1 => { :next_state => "F", :dir => -1, val: 0 },
  },
  "E" => {
    0 => { :next_state => "A", :dir => -1, val: 1 },
    1 => { :next_state => "C", :dir => -1, val: 1 },
  },
  "F" => {
    0 => { :next_state => "E", :dir => -1, val: 1 },
    1 => { :next_state => "A", :dir => 1,  val: 1 },
  },
}

tape = Hash.new 0
cursor = 0
state = "A"
12208951.times do
  bit = tape[cursor]
  next_state = states[state][bit][:next_state]
  tape[cursor] = states[state][bit][:val]

  cursor += states[state][bit][:dir]
  state = next_state
end

p tape.values.count 1
