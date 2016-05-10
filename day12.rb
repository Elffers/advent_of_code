# --- Day 12: JSAbacusFramework.io ---

# Santa's Accounting-Elves need help balancing the books after a recent order.
# Unfortunately, their accounting software uses a peculiar storage format.
# That's where you come in.

# They have a JSON document which contains a variety of things: arrays
# ([1,2,3]), objects ({"a":1, "b":2}), numbers, and strings. Your first job is
# to simply find all of the numbers throughout the document and add them
# together.

# For example:

# [1,2,3] and {"a":2,"b":4} both have a sum of 6.  [[[3]]] and
# {"a":{"b":4},"c":-1} both have a sum of 3.  {"a":[-1,1]} and [-1,{"a":1}] both
# have a sum of 0.  [] and {} both have a sum of 0.  You will not encounter any
# strings containing numbers.

# What is the sum of all numbers in the document?

require 'json'

def ary_sum array
  nums = []
  array.each do |el|
    case el
      # case statements use #===.
      # For Class, #=== is an alias of #instance_of
    when Integer
      nums << el
    when String
      nums << 0
    else
      nums << obj_sum(el)
    end
  end
  nums.reduce(:+)
end

def hash_sum hash
  nums = []
  hash.each do |k, v|
    case v
    when "red"
      return 0
    when String
      nums << 0
    when Integer
      nums << v
    else
      nums << obj_sum(v)
    end
  end
  nums.reduce(:+)
end

def obj_sum obj
  case obj
  when Array
    ary_sum obj
  when Hash
    hash_sum obj
  end
end

def sum json
  obj = JSON.parse json
  obj_sum obj
end

if __FILE__ == $0
  p sum File.read('day12_input.txt')
end
