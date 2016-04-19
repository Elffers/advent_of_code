require_relative 'day10'

describe "sequence" do
  it "generates next sequence" do
    expect(sequence 1).to eq "11"
  end

  it "works" do
    expect(sequence 11).to eq "21"
  end

  it "works" do
    expect(sequence 12).to eq "1112"
  end

  it "works" do
    expect(sequence 21).to eq "1211"
  end

  it "works" do
    expect(sequence 1121333).to eq "21121133"
  end
end

describe "run" do
  it "works" do
    expect(run 1, 1).to eq "11"
    expect(run 1, 2).to eq "21"
  end
end
