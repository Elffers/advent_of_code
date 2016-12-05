require_relative 'day05'

describe PasswordGenerator do
  let(:pg) { PasswordGenerator.new 'abc' }

  describe 'build_password' do
    it "builds password" do
      expected = '18f47a30'
      expect(pg.build_password).to eq expected
    end
  end
end
