class FloorCalculator

  def calculate_floor(input)
    input.each_char.reduce(0) do |floor, char|
      if char == "("
        floor + 1
      elsif char == ")"
        floor - 1
      else
        floor
      end
    end
  end
end

if $0 == __FILE__
  input = File.read('day1_input.txt')
  fc = FloorCalculator.new
  p fc.calculate_floor(input)
end
