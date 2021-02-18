require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
    PetApplicant.create!(pet: @pet1, applicant: @applicant1)
  end

  describe 'When I visit an applications show page' do
    it 'I can see name, full address, description, pets, and status' do

      visit "/applicants/#{@applicant1.id}"

      within("#applicant-#{@applicant1.id}") do
        expect(page).to have_content(@applicant1.name)
        expect(page).to have_content(@applicant1.full_address)
        expect(page).to have_link("Thor")
        expect(page).to have_content('In Progress')
      end
    end
  end

  describe 'When one or more pets are added to the application' do
    it 'I see a section to submit my application' do
      visit "/applicants/#{@applicant1.id}"

      within(".submit-application") do
        expect(page).to have_button('Submit Application')
      end
    end

    it 'I see an input to enter why I would make a good owner for these pet(s)' do
      visit "/applicants/#{@applicant1.id}"

      within(".submit-application") do
        expect(page.find_field(:good_home_description)).to be_truthy
      end
    end
  end

  describe 'When no pets are on the application' do
    it 'I do not see a section to submit my application' do
      expect(page).not_to have_button('Submit Application')
    end
  end

  describe 'When I fill in good home description input and submit' do
    it 'I am taken back to the applications show page' do
      visit "/applicants/#{@applicant1.id}"

      within(".submit-application") do
        fill_in :good_home_description, with: 'I have friends who have dogs.'

        click_button('Submit Application')
      end

      expect(page).to have_content('I have friends who have dogs.')
      expect(current_path).to eq("/applicants/#{@applicant1.id}")
    end

    it 'I see an indicator that the application is "Pending"' do
      visit "/applicants/#{@applicant1.id}"

      within(".submit-application") do
        click_button('Submit Application')
      end
      expect(page).to have_content('Pending')
    end

    it 'I do not see a section to add more pets to this application' do
      visit "/applicants/#{@applicant1.id}"

      within(".submit-application") do
        click_button('Submit Application')
      end
      expect(page).not_to have_content('Add a Pet to this Application')
    end
  end

  describe 'Creating a pet applicant that already exists' do
    it 'has an input validation that wont create a new record' do
      visit "/applicants/#{@applicant1.id}"
      fill_in :search, with: 'Thor'
      click_button('Search')
      click_button('Adopt this Pet')
      expect(page).to have_content('Pet is already added to this application.')
    end
  end
end
