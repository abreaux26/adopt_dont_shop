require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034, status: 1)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034, status: 1)

    @shelter1 = Shelter.create!(id: 1, name: 'Silly Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(id: 2, name: 'Shady Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(id: 3, name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
    @pet2 = @shelter2.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 4, sex: 'male')

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1)
    @pet_applicant2 = PetApplicant.create!(pet: @pet2, applicant: @applicant2)
  end

  describe 'When I visit the admin shelter index ("/admin/shelters")' do
    it 'I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'

      expect(@shelter1.name).to appear_before(@shelter3.name)
      expect(@shelter3.name).to appear_before(@shelter2.name)
      expect(@shelter1.name).to appear_before(@shelter2.name)
    end

    it 'I see a section for "Shelters with Pending Applications"' do
      visit '/admin/shelters'

      within(".pending-applicants") do
        expect(page).to have_content("Shelters with Pending Applications")
      end
    end

    it 'I see the name of every shelter that has a pending application' do
      visit '/admin/shelters'

      within(".pending-applicants") do
        expect(page).to have_content(@shelter2.name)
        expect(page).to have_content(@shelter1.name)
        expect(page).not_to have_content(@shelter3.name)
      end
    end

    it 'I see all those shelters are listed alphabetically' do
      visit '/admin/shelters'

      within(".pending-applicants") do
        expect(@shelter2.name).to appear_before(@shelter1.name)
      end
    end
  end
end
