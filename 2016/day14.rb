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
    thousand = thousand_hashes

    while indices.size < 64

      p indices.last
      digest = thousand.shift
      thousand << superhash(md5.hexdigest(salt + (1000+i).to_s))

      if /(.)\1\1/ =~ digest
        if match? $1, thousand
          indices << i
        end
      end
      i += 1
    end
    p indices
    indices.last
  end

  def thousand_hashes
    (0...1000).map do |x|
      # md5.hexdigest(salt + x.to_s)
      superhash(md5.hexdigest(salt + x.to_s))
    end
  end

  def match? char, hashes
    pentuple = char * 5

    hashes.each.with_index do |digest, i|
      return true if digest.include? pentuple
      # p i
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
  salt = 'qzyelonm'
  kg = KeyGenerator.new salt
  p kg.find_index
  #
  # salt = 'abc'
  # kg = KeyGenerator.new salt
  # p kg.find_index
  # part 1: 22728
  # part 2: 22551
end
