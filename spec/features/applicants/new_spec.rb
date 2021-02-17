require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the pet index page' do
    it 'Then I see a link to "Start an Application"' do
      visit '/pets'

      expect(page).to have_link('Start an Application')
    end
  end

  describe 'When I click this link' do
    it 'Then I am taken to the new application page where I see a form' do
      visit '/pets'
      click_link 'Start an Application'
      expect(current_path).to eq('/applicants/new')
    end

    it 'I fill in an application' do
      visit '/pets'
      click_link 'Start an Application'

      fill_in 'name', with: 'Angel'
      fill_in 'address', with: '008 Drive'
      fill_in 'city', with: 'Denver'
      fill_in 'state', with: 'CO'
      fill_in 'zip', with: 80202

      click_button('Submit')
      new_id = Applicant.last.id
      expect(current_path).to eq("/applicants/#{new_id}")

      within("#applicant-#{new_id}") do
        expect(page).to have_content('Angel')
        expect(page).to have_content(Applicant.last.full_address)
        expect(page).to have_content('In Progress')
      end
    end
  end

  describe 'When I visit the new application page' do
    it 'I fail to fill in any form fields and see a message' do
      visit '/applicants/new'
      click_button('Submit')
      expect(page).to have_content("Applicant not created: Required information missing.")
      expect(page).to have_button('Submit')
      expect(current_path).to eq('/applicants/new')
    end
  end
end
