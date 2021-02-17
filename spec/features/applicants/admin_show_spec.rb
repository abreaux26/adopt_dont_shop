require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034)

    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1)
    @pet_applicant2 = PetApplicant.create!(pet: @pet1, applicant: @applicant2)
  end

  describe 'When I visit an admin application show page' do
    it 'I see a button to approve the application for that specific pet' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        expect(page).to have_button('Approve')
      end
    end

    it 'I click "Approve" and no longer see a button' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
      end
      expect(page).not_to have_button('Approve')
      expect(current_path).to eq("/admin/applicants/#{@applicant1.id}")
    end

    it 'I see an indicator next to the pet that they have been approved' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
        expect(page).to have_content('Approved')
      end
    end

    it 'I see a button to reject the application for that specific pet' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        expect(page).to have_button('Reject')
      end
    end

    it 'I click "Reject" and no longer see a button' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Reject')
      end
      expect(page).not_to have_button('Reject')
      expect(current_path).to eq("/admin/applicants/#{@applicant1.id}")
    end

    it 'I see an indicator next to the pet that they have been rejected' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Reject')
        expect(page).to have_content('Rejected')
      end
    end
  end

  describe 'I visit the admin application show page for one of the applications' do
    it 'I approve the pet for that application and I see buttons to approve or reject on the other application' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
      end

      visit "/admin/applicants/#{@applicant2.id}"

      within("#admin-applicant-#{@applicant2.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end
    end

    it 'I reject the pet for that application' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Reject')
      end

      visit "/admin/applicants/#{@applicant2.id}"

      within("#admin-applicant-#{@applicant2.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end
    end
  end

  describe 'When I approve all pets for an application' do
    it 'I see the applications status has changed to "Accepted" on the application show page' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
        expect(page).to have_content('Accepted')
      end
    end
  end

  describe 'When I reject one pet for an application' do
    it 'I see the applications status has changed to "Accepted" on the application show page' do
      visit "/admin/applicants/#{@applicant2.id}"

      within("#admin-applicant-#{@applicant2.id}") do
        click_button('Reject')
        expect(page).to have_content('Rejected')
      end
    end
  end

  describe 'When application is accepted and I visit the show pages for those pets' do
    it 'I see that those pets are no longer "adoptable"' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Approve')
      end

      @applicant1.pets.each do |pet|
        visit "/pets/#{pet.id}"
        expect(page).to have_content('Adoption Status: false')
        expect(pet.adoptable?).to be_falsy
      end
    end
  end

  describe 'When application is rejected and I visit the show pages for those pets' do
    it 'I see that those pets are still "adoptable"' do
      visit "/admin/applicants/#{@applicant1.id}"

      within("#admin-applicant-#{@applicant1.id}") do
        click_button('Reject')
      end

      @applicant1.pets.each do |pet|
        visit "/pets/#{pet.id}"
        expect(page).to have_content('Adoption Status: true')
        expect(pet.adoptable?).to be_truthy
      end
    end
  end
end
