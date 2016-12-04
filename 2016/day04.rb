# --- Day 4: Security Through Obscurity ---

# Finally, you come across an information kiosk with a list of rooms. Of
# course, the list is encrypted and full of decoy data, but the instructions
# to decode the list are barely hidden nearby. Better remove the decoy data
# first.

# Each room consists of an encrypted name (lowercase letters separated by
# dashes) followed by a dash, a sector ID, and a checksum in square brackets.

# A room is real (not a decoy) if the checksum is the five most common letters
# in the encrypted name, in order, with ties broken by alphabetization. For
# example:

# aaaaa-bbb-z-y-x-123[abxyz] is a real room because the most common letters
# are a (5), b (3), and then a tie between x, y, and z, which are listed
# alphabetically.
# a-b-c-d-e-f-g-h-987[abcde] is a real room because although the letters are
# all tied (1 of each), the first five are listed alphabetically.
# not-a-real-room-404[oarel] is a real room.
# totally-real-room-200[decoy] is not.
#
# Of the real rooms from the list above, the sum of their sector IDs is 1514.

# What is the sum of the sector IDs of the real rooms?

class Decrypter

  def parse_room room
    /(?<name>\D+)(?<id>\d+)\[(?<checksum>\w+)/ =~ room
    actual_checksum = find_checksum name
    if actual_checksum == checksum
      return id.to_i
    end
  end

  def find_checksum name
    letters = name.delete("-") #.chars.sort
    counts = Hash.new 0

    letters.each_char do |char|
      counts[char] += 1
    end

    grouped_by_counts = Hash.new { |h, k| h[k] = [] }
    counts.each do |char, count|
      grouped_by_counts[count] << char
    end

    max_counts = grouped_by_counts.keys.sort.reverse

    actual_checksum = ""

    max_counts.each do |count|
      grouped_by_counts[count].sort.each do |char|
        actual_checksum += char
        return actual_checksum if actual_checksum.size == 5
      end
    end
  end

  def find_sum rooms
    sum = 0
    rooms.each do |room|
      if id = parse_room(room)
        sum += id
      end
    end

    sum
  end
end


if $0 == __FILE__
  rooms = File.readlines('day04.in')
  d = Decrypter.new
  p d.find_sum rooms
end
