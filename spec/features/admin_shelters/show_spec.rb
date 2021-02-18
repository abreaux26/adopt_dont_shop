require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034, status: 1)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034, status: 2)

    @shelter1 = Shelter.create!(id: 1, name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(id: 2, name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(id: 3, name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male', adoptable: false)
    @pet2 = @shelter2.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 4, sex: 'male', adoptable: true)
    @pet3 = @shelter2.pets.create!(image:'', name: 'Pepper', description: 'dog', approximate_age: 4, sex: 'male', adoptable: true)
    @pet4 = @shelter1.pets.create!(image:'', name: 'Sam', description: 'dog', approximate_age: 2, sex: 'male', adoptable: false)

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1)
    @pet_applicant2 = PetApplicant.create!(pet: @pet2, applicant: @applicant2)
    @pet_applicant3 = PetApplicant.create!(pet: @pet3, applicant: @applicant1)
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

    it 'I see the number of pets that have been adopted from that shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".statistics") do
        expect(page).to have_content(@shelter1.adopted_pet_count)
      end
    end

    it 'I see a section titled "Action Required"' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".action-required") do
        expect(page).to have_content('Action Required')
      end
    end

    it 'I see a list of all pets for this shelter that have a pending application and have not yet been marked "approved" or "rejected"' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".action-required") do
        expect(page).to have_content(@pet1.name)
        expect(page).not_to have_content(@pet2.name)
      end
    end

    it 'I see a link to the admin application show page where I can accept or reject the pet.' do
      visit "/admin/shelters/#{@shelter1.id}"

      within(".action-required") do
        expect(page).to have_link('Go to Application')
        click_link('Go to Application')
      end
      expect(current_path).to eq("/admin/applicants/#{@applicant1.id}")
      expect(page).to have_button('Approve')
      expect(page).to have_button('Reject')
    end
  end
end
