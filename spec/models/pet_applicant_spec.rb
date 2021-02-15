require 'rails_helper'

RSpec.describe PetApplicant do
  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 4, sex: 'male')
    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1, adoption_status: 1)

    @applicant2 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @pet2 = @shelter1.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 2, sex: 'male')
    @pet_applicant2 = PetApplicant.create!(pet: @pet2, applicant: @applicant2, adoption_status: 0)
  end

  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'class methods' do
    it 'returns a pet applicant record with matching pet and applicant ids' do

      expect(PetApplicant.find_by(@pet1.id, @applicant1.id)).to eq(@pet_applicant1)
    end

    it 'returns "Approved" if the pet on the application is approved' do
      pet_applicant = PetApplicant.find_by(@pet1.id, @applicant1.id)
      expect(pet_applicant.adoption_status).to eq('Approved')
    end

    it 'returns "Rejected" if the pet on the application is rejected' do

      pet_applicant = PetApplicant.find_by(@pet2.id, @applicant2.id)
      expect(pet_applicant.adoption_status).to eq('Rejected')
    end
  end
end
