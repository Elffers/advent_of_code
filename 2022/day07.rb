input = File.read("/Users/hhhsu/sandbox/aoc/2022/inputs/day07.in").split("\n")

MAX_SIZE = 100_000
TOTAL_SPACE = 70000000
SPACE_NEEDED = 30000000

fs = {}
path = []
pwd = "/"

def filename path, name
  path.join("/")+ "/#{name}"
end

input.each do |cmd|
  if cmd[0] == "$"
    instr = cmd[2..-1]
    case instr
    when "ls"
      next
    else
      /cd (?<dir>\D+)$/ =~ instr
      if dir == "/"
        fs[dir] = []
      elsif dir == ".."
        path.pop
        pwd = path.join("/")
      else
        pwd = filename path, dir
        path << dir
      end
    end

  else # list of files in pwd
    x, name = cmd.split(" ")
    fn = filename path, name

    if x == "dir"
      fs[fn] = []
    else
      fs[fn] = x.to_i # file size
    end

    fs[pwd] << fn
  end
end

def dir_size f, fs
  if fs[f].is_a? Integer
    return fs[f]
  else
    fs[f].map do |f|
      dir_size f, fs
    end.sum
  end
end

total = 0
sizes = Hash.new 0

fs.each do |(dir, ls)|
  if ls.is_a? Array # subdir
    size = dir_size dir, fs
    sizes[dir] = size
    if size <= MAX_SIZE
      total += size
    end
  end
end

p "Part 1: #{total}"

unused = TOTAL_SPACE - sizes["/"]
min_needed = SPACE_NEEDED - unused
min_size = TOTAL_SPACE

sizes.values.each do |size|
  if size >= min_needed && size < min_size
    min_size = size
  end
end

p "Part 2: #{min_size}"
