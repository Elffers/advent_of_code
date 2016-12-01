require_relative 'day15'

describe Cookie do
  let(:input) { StringIO.new(
    <<INPUT
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
INPUT
  ) }

  let(:cookie) { Cookie.new input.readlines }


  describe 'parse' do
    it "creates store for reindeer" do
      cookie.parse

      expected = {
        "Butterscotch" => {
          capacity: -1,
          durability: -2,
          flavor: 6,
          texture: 3,
          calories: 8
        },

        "Cinnamon" => {
          capacity: 2,
          durability: 3,
          flavor: -2,
          texture: -1,
          calories: 3
        },
      }
p cookie.ingredients
      expect(cookie.ingredients).to eq expected
    end
  end

  describe "score" do
    xit "returns score" do
    end
  end
end
