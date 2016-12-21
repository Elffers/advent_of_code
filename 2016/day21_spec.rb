require_relative 'day21'

describe 'swap position' do
  let(:word) { 'abcde' }

  it 'works' do
    actual = swap_position word, 1, 2
    expect(actual).to eq 'acbde'
  end

  it 'works in reverse' do
    word = 'acbde'
    actual = swap_position word, 2, 1
    expect(actual).to eq 'abcde'
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
    actual = swap_letters expected, 'c', 'a'
    expect(actual).to eq word
  end
end

describe 'rotate_right' do
  let(:word) { 'abcde' }
  let(:expected) { 'bcdea' }

  it 'works' do
    actual = rotate_left word, 1
    expect(actual).to eq expected
  end

end

describe 'rotate_left' do
  let(:word) { 'abcde' }
  let(:expected) { 'eabcd' }

  it 'works' do
    actual = rotate_right word, 1
    expect(actual).to eq expected
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

  it 'works' do
    expect(move_position expected, 4, 1).to eq word
  end
end

describe 'rotate_pos' do
  let(:word) { 'ecabd' }
  let(:expected) { 'decab' }
  let(:word2) { 'abcdefg' }
  let(:expected2) { 'efgabcd' }

  it 'works' do
    expect(rotate_pos word, 'd').to eq expected
    expect(rotate_pos word2, 'c').to eq expected2
  end

  it 'works in reverse' do
    expect(rotate_pos expected, 'd', false).to eq word
    expect(rotate_pos expected2, 'c').to eq word2
  end
end
