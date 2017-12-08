# part 2 only

class Spiral
  INPUT = 325489
  attr_accessor :x, :y, :dir, :grid

  def initialize
    @grid = Hash.new { |h, k| h[k] = Hash.new 0}
    @x = 0
    @y = 0
    @dir = "east"
  end

  def fill
    val = 1
    grid[x][y] = val

    while val < INPUT
      step
      val = calculate_value
      grid[x][y] = val
    end

    val
  end

  private

  def step
    case dir
    when "east"
      self.x += 1
    when "west"
      self.x -= 1
    when "north"
      self.y += 1
    when "south"
      self.y -= 1
    end
    turn
  end

  # Change direction if at corner
  def turn
    if southwest
      self.dir = "east"
    end
    if northeast
      self.dir = "west"
    end
    if northwest
      self.dir = "south"
    end
    if southeast
      self.dir = "north"
    end
  end

  # third quadrant
  def southwest
    x == y && x <= 0
  end

  # fourth quadrant
  def southeast
    x-1 == -y && x > 0 && y <= 0
  end

  # first quadrant
  def northeast
    x == y && x > 0
  end

  # second quadrant
  def northwest
    -x == y && y > 0
  end

  # If an adjacent coordinate hasn't been visited yet, value will be 0
  def calculate_value
    grid[x-1][y+1] +
      grid[x][y+1] +
      grid[x+1][y+1] +

      grid[x-1][y] +
      grid[x+1][y] +

      grid[x-1][y-1] +
      grid[x][y-1] +
      grid[x+1][y-1]
  end
end

s = Spiral.new
p s.fill
