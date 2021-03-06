require 'rails_helper'

RSpec.describe PetApplicant do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'validations' do
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :applicant_id }
  end

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

  describe 'class methods' do
    it 'returns a pet applicant record with matching pet and applicant ids' do

      expect(PetApplicant.find_by(@pet1.id, @applicant1.id)).to eq(@pet_applicant1)
    end

    it 'returns true if any pet applicant is pending' do
      expect(PetApplicant.any_pending?(@applicant4.id)).to be_truthy
    end

    it 'returns false if any pet applicant is pending' do
      expect(PetApplicant.any_pending?(@applicant1.id)).to be_falsy
    end

    it 'returns true if all pet applicants are approved' do
      expect(PetApplicant.all_approved?(@applicant3.id)).to be_truthy
    end

    it 'returns false if all pet applicants are not approved' do
      expect(PetApplicant.all_approved?(@applicant1.id)).to be_falsy
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

    it 'returns true if the pet applicant is pending and pet is adoptable' do
      expect(@pet_applicant6.pending_and_pet_adoptable?).to be_truthy
    end

    it 'returns false if the pet applicant is pending and pet is adoptable' do
      expect(@pet_applicant4.pending_and_pet_adoptable?).to be_falsy
    end
  end
end
