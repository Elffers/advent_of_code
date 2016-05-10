require_relative 'day12'

describe "sum" do
  it "works" do
    expect(sum "[1,2,3]").to eq 6
    expect(sum '{"a":2,"b":4}"').to eq 6
    expect(sum '{"a":{"b":4},"c":-1}').to eq 3
  end
end
