require_relative 'day09'

describe 'decompressed_length' do
  it "returns decompressed length" do
    input = "ADVENT"
    expect(decompressed_length input).to eq 6
  end

  it "returns decompressed length" do
    input = "A(1x5)BC"
    expect(decompressed_length input).to eq 7
  end

  it "returns decompressed length" do
    input = "(3x3)XYZ"
    expect(decompressed_length input).to eq 9
  end

  it "returns decompressed length" do
    input = "A(2x2)BCD(2x2)EFG"
    expect(decompressed_length input).to eq 11
  end

  it "returns decompressed length" do
    input = "(6x1)(1x3)A"
    expect(decompressed_length input).to eq 6
  end

  it "returns decompressed length" do
    input = "X(8x2)(3x3)ABCY"
    expect(decompressed_length input).to eq 18
  end
end

describe 'recursive_decompress' do
  it "returns length of string with no marker" do
    str = "XYZ"
    expect(recursive_decompress str).to eq 3
  end

  it "returns length of string that starts with marker" do
    str = '(3x3)XYZ'
    expect(recursive_decompress str).to eq 9
  end

  it "returns length of string that starts with marker" do
    str = '(3x3)XYZT'
    expect(recursive_decompress str).to eq 10
  end

  it "returns length of string that starts with marker" do
    str = 'AB(3x3)XYZAB'
    expect(recursive_decompress str).to eq 13
  end

  it "returns length of string that contains with marker" do
    str = 'AB(2x3)XY'
    expect(recursive_decompress str).to eq 8
  end

  it "returns length of string that contains with marker" do
    str = 'AB(2x3)XYZ'
    expect(recursive_decompress str).to eq 9
  end

  it "returns length of string that contains with marker" do
    str = 'AB(2x3)XYZ(3x3)ABC'
    expect(recursive_decompress str).to eq 18
  end

  it "returns length of string that contains with marker" do
    str = 'A(2x3)XYABCD(3x3)ABC'
    expect(recursive_decompress str).to eq 20
  end

  it "works for decompressed substring with marker" do
    str = "X(8x2)(3x3)ABCY"
    expect(recursive_decompress str).to eq 20
  end

  it "works for decompressed substring with marker" do
    str = "(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN"
    expect(recursive_decompress str).to eq 445
  end

end
