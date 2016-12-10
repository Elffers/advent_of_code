require_relative 'day10'

describe BotManager do
  let(:b) { BotManager.new }
  let(:input) { StringIO.new(<<INPUT
value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2
INPUT
                            ).readlines.map { |x| x.strip } }

  describe 'parse' do
    it "sets chips on bots" do
      instr = "value 23 goes to bot 68"
      b.parse instr
      expect(b.bots["68"]).to eq [23]
      expect(b.queue).to be_empty
    end

    it "enqueues when bot has one chip" do
      b.bots["76"] = [1]
      instr = "bot 76 gives low to bot 191 and high to bot 21"
      b.parse instr

      queued = {
        low: { dest: 'bot', id: '191' },
        hi: { dest: 'bot', id: '21' },
      }

      expect(b.queue["76"]).to eq queued
      expect(b.bots["191"]).to be_empty
      expect(b.output["21"]).to be_nil
    end

    it "enqueues when bot has no chip" do
      instr = "bot 76 gives low to bot 191 and high to bot 21"
      b.parse instr

      queued = {
        low: { dest: 'bot', id: '191' },
        hi: { dest: 'bot', id: '21' },
      }

      expect(b.queue["76"]).to eq queued
      expect(b.bots["76"]).to be_empty
    end

    it "works" do
      input.each do |instr|
        b.parse instr
      end

      expect(b.output["0"]).to eq 5
      expect(b.output["1"]).to eq 2
      expect(b.output["2"]).to eq 3
      expect(b.queue).to be_empty
    end
  end

  describe 'enqueue' do
    it "delivers when bot has two chips" do
      instr = "bot 76 gives low to bot 191 and high to output 21"
      b.enqueue(instr)

      expected = {
        low: { dest: 'bot', id: '191' },
        hi: { dest: 'output', id: '21' },
      }

      expect(b.queue['76']).to eq expected
    end
  end

  describe 'deliver' do
    def set_both_chips_for id
      b.bots[id] = [3, 2]
    end

    def enqueue_for id
      instr = "bot #{id} gives low to bot 191 and high to output 21"
      b.enqueue(instr)
    end

    it "delivers chips to correct destinations" do
      set_both_chips_for "76"
      enqueue_for "76"

      b.deliver "76"

      expect(b.bots["191"]).to eq [2]
      expect(b.output["21"]).to eq(3)
      expect(b.queue).to be_empty
    end

    it "does not deliver if bot doesn't have both chips" do
      enqueue_for "76"

      b.deliver "76"

      expect(b.queue["76"]).to_not be_empty
      expect(b.bots["191"]).to be_empty
      expect(b.output["21"]).to be_nil
    end
  end
end
