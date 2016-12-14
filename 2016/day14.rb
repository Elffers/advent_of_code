require 'digest'

class KeyGenerator
  attr_accessor :md5, :salt

  def initialize salt
    @md5 = Digest::MD5.new
    @salt = salt
  end

  def find_index
    i = 0
    indices = []

    while indices.size < 64
      p indices.last

      digest = md5.hexdigest(salt + i.to_s)
      superdigest = superhash digest

      if /(.)\1\1/ =~ superdigest
        if match? i, $1
          indices << i
        end
      end
      i += 1
    end
    p indices
    indices.last
  end

  def match? i, char
    pentuple = char * 5

    (i+1 ..1000+i).each do |j|
      key = salt + j.to_s
      digest = superhash(md5.hexdigest key)
      if digest.include? pentuple
        p j
        return true
      end
    end
    false
  end

  def superhash digest
    2016.times do
      digest = md5.hexdigest digest
    end
    digest
  end

end

if $0 == __FILE__
  # salt = 'qzyelonm'
  # kg = KeyGenerator.new salt
  # p kg.find_index
  #
  salt = 'abc'
  kg = KeyGenerator.new salt
  p kg.find_index
  # # 22728
end
