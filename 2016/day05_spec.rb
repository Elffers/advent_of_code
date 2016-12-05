require_relative 'day05'

describe PasswordGenerator do
  let(:pg) { PasswordGenerator.new 'abc' }

  describe 'build_password' do
    it "builds password" do
      expected = '18f47a30'
      expect(pg.build_password_in_order).to eq expected
    end
  end

  describe 'build_password2' do
    it "builds password" do
      expected = '05ace8e3'
      expect(pg.build_password_random_order).to eq expected
    end
  end
end
