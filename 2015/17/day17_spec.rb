require_relative 'day17'

describe 'combinations' do
  it "returns number of ways to add up to given sum" do
    sizes = [10, 5]
    expect(combinations 15, sizes).to eq 1
  end

  it "for duplicate values" do
    sizes = [10, 10, 5]
    expect(combinations 15, sizes).to eq 2

    sizes = [10, 10, 5, 5]
    expect(combinations 15, sizes).to eq 4

    sizes = [10, 10, 10, 5, 5]
    expect(combinations 15, sizes).to eq 6
  end

  it "for sizes that don't all add up" do
    sizes = [10, 6, 5]
    expect(combinations 15, sizes).to eq 1
  end

  it "when the first element is too big" do
    sizes = [6, 3, 2]
    expect(combinations 5, sizes).to eq 1
  end

  it "when some elements aren't used" do
    sizes = [10, 6, 3, 2]
    expect(combinations 15, sizes).to eq 1
  end

  it "works with duplicate" do
    sizes = [5, 5]
    expect(combinations 10, sizes).to eq 1
  end

  it "works with duplicate" do
    sizes = [10, 5, 5]
    expect(combinations 10, sizes).to eq 2
  end

  it 'works with duplicate within subset' do
    sizes = [15, 10, 5, 5]
    expect(combinations 20, sizes).to eq 3
  end

  it "works" do
    sizes = [20, 15, 10, 5, 5]
    expect(combinations 25, sizes).to eq 4
  end

  it "works" do
    sizes = [20, 15, 10, 10, 5, 5]
    expect(combinations 25, sizes).to eq 7
  end
end
