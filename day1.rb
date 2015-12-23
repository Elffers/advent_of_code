class FloorCalculator

  def calculate_floor(input)
    floor = 0
    input.each_char do |char|
      if char == "("
        floor += 1
      elsif char == ")"
        floor -=1
      end
    end
    floor
  end
end

if $0 == __FILE__
  input = File.read('day1_input.txt')
  fc = FloorCalculator.new
  p fc.calculate_floor(input)
end
