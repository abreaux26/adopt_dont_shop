require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034, good_home_description: 'I love dogs.', status: 0)

    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
    @pet2 = @shelter2.pets.create!(image:'', name: 'fluff', description: 'cat', approximate_age: 3, sex: 'female')
    @pet3 = @shelter1.pets.create!(image:'', name: 'Mr. Fluffy', description: 'dog', approximate_age: 4, sex: 'male')
  end

  describe 'When I click "Adopt this Pet"' do
    it 'I am taken back to the application show page' do
      visit "/applicants/#{@applicant1.id}"
      fill_in :search, with: 'thor'
      click_button('Search')
      click_button('Adopt this Pet')
      expect(current_path).to eq("/applicants/#{@applicant1.id}")
    end

    it 'I see the Pet I want to adopt listed on this application' do
      visit "/applicants/#{@applicant1.id}"
      fill_in :search, with: 'Thor'
      click_button('Search')
      click_button('Adopt this Pet')
      expect(current_path).to eq("/applicants/#{@applicant1.id}")

      within("#applicant-#{@applicant1.id}") do
        expect(page).to have_content(@pet1.name)
      end
    end
  end
end
