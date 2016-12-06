require_relative 'day06'
describe 'parse' do
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

  it "returns highest count at each index" do
    col = t.first
    expect(find_max col).to eq 'e'
  end

  it 'finds word' do
    expect(build t).to eq 'easter'
  end
end

