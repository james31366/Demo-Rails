require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "say_hello" do
    it "returns string 'Hello' " do
      admin = Admin.new
      expect(admin.say_hello).to eq('Hello')
    end
  end

  describe "admin emails cannot contain a word 'bob'" do
    context 'emails contains bob' do
      it 'is invalid' do
        admin = Admin.new(email: 'bob@gmail.com', password: '1')
        expect(admin.valid?).to eq false
      end
    end

    context 'emails does not contain bob' do
      it 'is valid' do
        admin = Admin.new(email: 'bed@gmail.com', password: '1')
        expect(admin.valid?).to eq true
      end
    end
  end
end