require 'rails_helper'

RSpec.describe PetApplicant do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034)
    @applicant3 = Applicant.create!(name: 'Amber', address: '123 Ave', city: 'Conway', state: 'AR', zip: 72034)
    @applicant4 = Applicant.create!(name: 'Levi', address: '123 Cove', city: 'Conway', state: 'AR', zip: 72034)

    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 4, sex: 'male')
    @pet2 = @shelter1.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 2, sex: 'male')

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1, adoption_status: 2)
    @pet_applicant2 = PetApplicant.create!(pet: @pet2, applicant: @applicant2, adoption_status: 1)
    @pet_applicant3 = PetApplicant.create!(pet: @pet2, applicant: @applicant1, adoption_status: 1)
    @pet_applicant4 = PetApplicant.create!(pet: @pet1, applicant: @applicant3, adoption_status: 2)
    @pet_applicant5 = PetApplicant.create!(pet: @pet2, applicant: @applicant3, adoption_status: 2)
    @pet_applicant6 = PetApplicant.create!(pet: @pet2, applicant: @applicant4)
  end

  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'class methods' do
    it 'returns a pet applicant record with matching pet and applicant ids' do

      expect(PetApplicant.find_by(@pet1.id, @applicant1.id)).to eq(@pet_applicant1)
    end
  end

  describe 'instance methods' do
    it 'returns "Pending" if the pet application has neither been approved or rejected' do
      expect(@pet_applicant6.adoption_status).to eq('pending')
    end

    it 'returns "Approved" if the pet on the application is approved' do
      expect(@pet_applicant1.adoption_status).to eq('approved')
    end

    it 'returns "Rejected" if the pet on the application is rejected' do
      expect(@pet_applicant2.adoption_status).to eq('rejected')
    end
  end
end
