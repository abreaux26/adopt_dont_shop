require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter1 = Shelter.create!(id: 1, name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(id: 2, name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(id: 3, name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male', adoptable: true)
    @pet2 = @shelter2.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 4, sex: 'male', adoptable: true)
    @pet3 = @shelter2.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 4, sex: 'male', adoptable: false)
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

    it 'I see a section for statistics' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".statistics") do
        expect(page).to have_content('Statistics')
      end
    end

    it 'I see the average age of all adoptable pets for that shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".statistics") do
        expect(page).to have_content(@shelter1.average_age)
      end
    end

    it 'I see the number of pets at that shelter that are adoptable' do
      visit "/admin/shelters/#{@shelter2.id}"

      within(".statistics") do
        expect(page).to have_content(@shelter2.adoptable_pet_count)
      end
    end
  end
end
