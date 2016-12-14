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
    window = thousand_hashes

    while indices.size < 64
      digest = window.shift
      key = md5.hexdigest(salt + (1000+i).to_s)
      window << superhash(key)

      if (/(.)\1\1/ =~ digest) && match_in?($1, window)
        indices << i
      end

      i += 1
    end

    indices.last
  end

  def thousand_hashes
    (0...1000).map do |x|
      key = md5.hexdigest(salt + x.to_s)
      superhash key
    end
  end

  def match_in? char, hashes
    pentuple = char * 5
    hashes.each.with_index do |digest, i|
      return true if digest.include? pentuple
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

  # salt = 'abc'
  # kg = KeyGenerator.new salt
  # p kg.find_index
  # part 1: 22728
  # part 2: 22551
end
