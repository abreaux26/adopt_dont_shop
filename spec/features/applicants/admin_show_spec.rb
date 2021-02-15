require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
    PetApplicant.create!(pet: @pet1, applicant: @applicant1)
  end

  describe 'When I visit an admin application show page' do
    it 'I see a button to approve the application for that specific pet' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        expect(page).to have_button('Approve')
      end
    end

    it 'I click "Update" and no longer see a button' do
      visit "/admin/applicants/#{@applicant1.id}"
      
      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
      end
      expect(page).not_to have_button('Approve')
      expect(current_path).to eq("/admin/applicants/#{@applicant1.id}")
    end
  end
end

# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
