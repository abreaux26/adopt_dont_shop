require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)
  end

  describe 'When I visit the admin shelter index ("/admin/shelters")' do
    it 'I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'

      expect(@shelter2.name).to appear_before(@shelter3.name)
      expect(@shelter3.name).to appear_before(@shelter1.name)
      expect(@shelter2.name).to appear_before(@shelter1.name)
    end
  end
end
