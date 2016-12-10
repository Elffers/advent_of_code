require_relative 'day09'

describe 'recursive_decompress' do
  it "returns length of string with no marker" do
    str = "XYZ"
    expect(recursive_decompress str).to eq 3
  end

  it "returns length of string that starts with marker" do
    str = decompress('(3x3)XYZ') #9
    expect(recursive_decompress str).to eq 9
  end

  xit "works for decompressed substring with marker" do
    str = "X(8x2)(3x3)ABCY becomes XABCABCABCABCABCABCY"
    expect(recursive_decompress str).to eq 20
  end

  xit "works for decompressed substring with marker" do
    str = "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
    expect(recursive_decompress str).to eq 445
  end

end
