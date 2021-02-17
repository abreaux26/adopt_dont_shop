require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter1 = Shelter.create!(id: 1, name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(id: 2, name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(id: 3, name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)
  end

  describe 'When I visit an admin shelter show page' do
    it 'I click the link and it takes me to "/admin/shelters/:id"' do
      visit "/admin/shelters"

      within("#shelter-#{@shelter1.id}") do
        click_link("#{@shelter1.name}")
      end
      expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
    end

    it 'I see that shelters name and full address' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content(@shelter1.name)
      expect(page).to have_content(@shelter1.full_address)
    end
  end
end
