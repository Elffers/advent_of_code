require_relative 'day08'

describe Auth do
  let(:auth) { Auth.new 3, 7 }

  describe 'follow instr' do
    it 'works' do
      instr = 'rect 3x2'
      auth.follow instr
      expect(auth.board).to eq([%w[# # # . . . .],
                                %w[# # # . . . .],
                                %w[. . . . . . .]])

      instr = 'rotate column x=1 by 1'
      auth.follow instr
      expect(auth.board).to eq([%w[# . # . . . .],
                                %w[# # # . . . .],
                                %w[. # . . . . .]])

      instr = 'rotate row y=0 by 4'
      auth.follow instr
      expect(auth.board).to eq([%w[. . . . # . #],
                                %w[# # # . . . .],
                                %w[. # . . . . .]])

      instr = 'rotate column x=1 by 1'
      auth.follow instr
      expect(auth.board).to eq([%w[. # . . # . #],
                                %w[# . # . . . .],
                                %w[. # . . . . .]])

      instr = 'rotate column x=2 by 1'
      auth.follow instr
      expect(auth.board).to eq([%w[. # . . # . #],
                                %w[# . . . . . .],
                                %w[. # # . . . .]])

      expect(auth.count_lit).to eq 6

      instr = 'rotate column x=6 by 1'
      auth.follow instr
      expect(auth.board).to eq([%w[. # . . # . .],
                                %w[# . . . . . #],
                                %w[. # # . . . .]])

      instr = 'rect 3x3'
      auth.follow instr
      expect(auth.board).to eq([%w[# # # . # . .],
                                %w[# # # . . . #],
                                %w[# # # . . . .]])

      instr = 'rotate row y=1 by 4'
      auth.follow instr
      expect(auth.board).to eq([%w[# # # . # . .],
                                %w[. . . # # # #],
                                %w[# # # . . . .]])
    end
  end

  describe 'shift' do
    it 'works' do
      row = %w[# # # # # .]
      expected = %w[. # # # # #]
      expect(auth.shift row, 1).to eq expected

      expected = %w[# . # # # #]
      expect(auth.shift row, 2).to eq expected

      expected = %w[# # . # # #]
      expect(auth.shift row, 3).to eq expected

      expected = %w[# # # . # #]
      expect(auth.shift row, 4).to eq expected

      expected = %w[# # # # . #]
      expect(auth.shift row, 5).to eq expected

      expected = %w[# # # # # .]
      expect(auth.shift row, 6).to eq expected

      expected = %w[. # # # # #]
      expect(auth.shift row, 7).to eq expected
    end

    it 'works' do
      row = %w[# # # . . . .]
      expected = %w[. . # # # . .]
      expect(auth.shift row, 2).to eq expected
    end

    it 'works' do
      row = %w[# # # . . . .]
      expected = %w[# . . . . # #]
      expect(auth.shift row, 5).to eq expected
    end

    it 'works' do
      row = %w[. # # . . . .]
      expected = %w[# . . . . . #]
      expect(auth.shift row, 5).to eq expected
    end
  end

end
