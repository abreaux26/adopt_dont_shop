require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
  end

  before :each do
    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)
  end

  describe 'class methods' do
    it 'Lists shelters in reverse alphabetical order by name ' do
      shelters = Shelter.order_by_desc_name
      expected = [@shelter2, @shelter3, @shelter1]

      expect(shelters).to eq(expected)
    end

    it 'returns name and address only' do
      shelter = Shelter.information(@shelter1.id)

      expect(shelter[:name]).to eq(@shelter1.name)
      expect(shelter[:address]).to be_in(@shelter1.full_address)
      expect(shelter[:city]).to be_in(@shelter1.full_address)
      expect(shelter[:state]).to be_in(@shelter1.full_address)
      expect(shelter[:zip].to_s).to be_in(@shelter1.full_address)
    end
  end

  describe 'instance methods' do
    it 'returns the full address' do
      full_address = "#{@shelter1.address} #{@shelter1.city}, #{@shelter1.state} #{@shelter1.zip}"

      expect(@shelter1.full_address).to eq(full_address)
    end
  end
end
