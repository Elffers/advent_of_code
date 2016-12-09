require_relative 'day11'

describe 'next_password' do
end

describe "prohibited?" do

  it "returns true if contains i, o, or l" do
    expect(prohibited? "abi").to be_truthy
    expect(prohibited? "abl").to be_truthy
    expect(prohibited? "abo").to be_truthy
  end

  it "returns false if it does not contain i, o, or l" do
    expect(prohibited? "abc").to be_falsey
  end

end

describe "has_double_repeated?" do
  it "returns true if there is a repeated letter" do
    expect(has_double_repeated? "aabb").to be_truthy
    expect(has_double_repeated? "xaaebb").to be_truthy
  end

  it "returns false if there is no repeated letter" do
    expect(has_double_repeated? "abb").to be_falsey
    expect(has_double_repeated? "abbg").to be_falsey
    expect(has_double_repeated? "abcc").to be_falsey
  end

  it 'returns false for triple letters' do
    expect(has_double_repeated? "bbb").to be_falsey
  end
end

describe "has_straight?" do
  it "returns true if string contains straight" do
    expect(has_straight? "abcc").to be_truthy
  end

  it "returns false if string does not contain straight" do
    expect(has_straight? "abdc").to be_falsey
  end
end

describe "valid?" do
  it "returns false for invalid password" do
    expect(valid? "hijklmmn").to be_falsey
    expect(valid? "abbceffg" ).to be_falsey
    expect(valid? "abbcegjk" ).to be_falsey
  end

  it "returns true for valid passwords" do
    expect(valid? "abcdffaa").to be_truthy
  end
end

describe "next_password?" do
  it "returns the next valid password" do
    expect(next_password "abcdefgh").to eq "abcdffaa"
    expect(next_password "ghijklmn").to eq "ghjaabcc"
  end
end

describe "next_try" do
  it "works" do
    expect(next_try "ghijklmn").to eq "ghjaaaaa"
  end
end
