require 'rails_helper'

RSpec.describe 'Shelter_Pets index page' do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034)
  end

  it "displays each applicant" do
    visit "/applicants"

    expect(page).to have_content(@applicant1.name)
    expect(page).to have_link(@applicant1.name)
    expect(page).to have_content(@applicant2.name)
    expect(page).to have_link(@applicant2.name)
  end

  it 'has current path' do
    visit "/applicants"
    click_link(@applicant1.name)
    expect(current_path).to eq("/applicants/#{@applicant1.id}")
  end
end
