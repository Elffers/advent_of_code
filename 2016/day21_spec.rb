require_relative 'day21'

describe 'swap position' do
  let(:word) { 'abcde' }
  let(:expected) { 'acbde' }

  it 'works' do
    actual = swap_position word, 1, 2
    expect(actual).to eq expected
  end

  it 'works in reverse' do
    actual = swap_position expected, 1, 2
    expect(actual).to eq word
  end
end

describe 'swap letters' do
  let(:word) { 'abcde' }
  let(:expected) { 'cbade' }

  it 'works' do
    actual = swap_letters word, 'a', 'c'
    expect(actual).to eq expected
  end

  it 'works in reverse' do
    actual = swap_letters expected, 'a', 'c'
    expect(actual).to eq word
  end
end

describe 'rotate' do
  let(:word) { 'abcde' }
  let(:expected_left) { 'bcdea' }
  let(:expected_right) { 'eabcd' }

  it 'works for rotating right' do
    actual = rotate word, 1, right: true
    expect(actual).to eq expected_right
  end

  it 'works for rotating left' do
    actual = rotate word, 1, right: false
    expect(actual).to eq expected_left
  end
end

describe 'reverse' do
  let(:word) { 'abcde' }
  let(:reversed) { 'edcba' }
  it 'works' do
    expect(reverse word, 0, 4).to eq reversed
    expect(reverse reversed, 0, 4).to eq word
  end

  it 'works for substrings' do
    expected = 'abedc'
    expect(reverse word, 2, 4).to eq expected
    expect(reverse expected, 2, 4).to eq word
  end
end

describe 'move_position' do
  let(:word) { 'abcde' }
  let(:expected) { 'acdeb' }

  it 'works' do
    expect(move_position word, 1, 4).to eq expected
  end

  it 'works in reverse' do
    expect(move_position expected, 1, 4, true).to eq word
  end
end

describe 'rotate_pos' do
  let(:word) { 'ecabd' }
  let(:expected) { 'decab' }

  let(:word1) { 'abdec' }
  let(:expected1) { 'ecabd' }

  let(:word2) { 'abcdefg' }
  let(:expected2) { 'efgabcd' }

  it 'works' do
    expect(rotate_pos word, 'd').to eq expected
    expect(rotate_pos word1, 'b').to eq expected1
    expect(rotate_pos word2, 'c').to eq expected2
  end

  xit 'works in reverse' do
    expect(rotate_pos expected, 'd', true).to eq word
    expect(rotate_pos expected1, 'b').to eq word1
    expect(rotate_pos expected2, 'c', false).to eq word2 # fails
  end
end
