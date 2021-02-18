require 'rails_helper'

RSpec.describe Applicant do
  describe 'relationships' do
    it { should have_many :pet_applicants }
    it { should have_many(:pets).through(:pet_applicants) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034)
    @applicant3 = Applicant.create!(name: 'Amber', address: '123 Ave', city: 'Conway', state: 'AR', zip: 72034)

    @shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
    @pet2 = @shelter1.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 4, sex: 'male')
    @pet3 = @shelter1.pets.create!(image:'', name: 'Pepper', description: 'dog', approximate_age: 1, sex: 'female')

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1, adoption_status: 2)
    @pet_applicant2 = PetApplicant.create!(pet: @pet1, applicant: @applicant2, adoption_status: 0)
    @pet_applicant3 = PetApplicant.create!(pet: @pet2, applicant: @applicant1, adoption_status: 2)
    @pet_applicant4 = PetApplicant.create!(pet: @pet3, applicant: @applicant3, adoption_status: 1)
  end

  describe 'instance methods' do
    it 'returns the full address' do
      full_address = "#{@applicant1.address} #{@applicant1.city}, #{@applicant1.state} #{@applicant1.zip}"

      expect(@applicant1.full_address).to eq(full_address)
    end
  end
end
