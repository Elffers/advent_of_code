require_relative 'day12'

describe "sum" do
  it "works" do
    expect(sum "[1,2,3]").to eq 6
    expect(sum '{"a":2,"b":4}').to eq 6
    expect(sum '{"a":{"b":4},"c":-1}').to eq 3
  end

  it "ignores values of 'red' in objects" do
    expect(sum '[1,{"c":"red","b":2},3]').to eq 4
    expect(sum '["a", 1,{"c":"red","b":2},3]').to eq 4
  end
end

describe "obj_sum" do
  it 'works' do
    expect(obj_sum [1, 2, 3]).to eq 6
    expect(obj_sum [1, [2, 1], 3]).to eq 7
    expect(obj_sum({"c"=> 1,"b" => 2})).to eq 3
  end
end
