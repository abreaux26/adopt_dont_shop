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
  end
end
