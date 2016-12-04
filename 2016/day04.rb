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
# --- Part Two ---

# With all the decoy data out of the way, it's time to decrypt this list and get moving.

# The room names are encrypted by a state-of-the-art shift cipher, which is nearly unbreakable without the right software. However, the information kiosk designers at Easter Bunny HQ were not expecting to deal with a master cryptographer like yourself.

# To decrypt a room name, rotate each letter forward through the alphabet a number of times equal to the room's sector ID. A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.

# For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.

# What is the sector ID of the room where North Pole objects are stored?

class Decrypter
  ALPHA = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]

  def parse_room room
    /(?<name>\D+)(?<id>\d+)\[(?<checksum>\w+)/ =~ room
    actual_checksum = find_checksum name
    if actual_checksum == checksum
      return id.to_i
    end
  end

  def find_checksum name
    letters = name.delete("-")
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

  def decrypt_rooms rooms
    rooms.each do |room|
      /(?<name>\D+)(?<id>\d+)\[(?<checksum>\w+)/ =~ room
      actual_checksum = find_checksum name
      if actual_checksum == checksum
        decrypted = decrypt name, id
        if /north/ =~ decrypted
          return [decrypted, id]
        end
      end
    end
  end

  def decrypt name, id
    mod = id.to_i % 26
    name.chars.map do |char|
      if char == "-"
        " "
      else
        i = ALPHA.index char
        new_index = (i + mod) % 26
        ALPHA[new_index]
      end
    end.join
  end
end


if $0 == __FILE__
  rooms = File.readlines('day04.in')
  d = Decrypter.new
  # p d.find_sum rooms
  p d.decrypt_rooms rooms
end
