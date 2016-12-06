require_relative 'day06'

describe 'build' do

  let(:input) { StringIO.new(<<INPUT
eedadn
drvtee
eandsr
raavrd
atevrs
tsrnev
sdttsa
rasrtv
nssdts
ntnada
svetve
tesnvt
vntsnd
vrdear
dvrsen
enarar
INPUT
                            ).readlines }
  let(:t) { transpose input }

  it 'returns word built with most frequently occuring characters' do
    expect(most_frequent t).to eq 'easter'
  end

  it 'returns word built with least frequently occuring characters' do
    expect(least_frequent t).to eq 'advent'
  end
end

