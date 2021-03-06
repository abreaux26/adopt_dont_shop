require 'rails_helper'

describe Shelter, type: :model do
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many(:pet_applicants).through(:pets) }
    it { should have_many(:applicants).through(:pet_applicants) }
  end

  before :each do
    @applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034, status: 1)
    @applicant2 = Applicant.create!(name: 'Chris', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034, status: 1)
    @applicant3 = Applicant.create!(name: 'Amber', address: '123 Drive', city: 'Conway', state: 'AR', zip: 72034, status: 1)

    @shelter1 = Shelter.create!(name: 'Silly Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
    @shelter2 = Shelter.create!(name: 'Shady Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
    @shelter3 = Shelter.create!(name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)

    @pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 4, sex: 'male', adoptable: false)
    @pet2 = @shelter2.pets.create!(image:'', name: 'Spark', description: 'dog', approximate_age: 2, sex: 'male')
    @pet3 = @shelter1.pets.create!(image:'', name: 'Pepper', description: 'dog', approximate_age: 2, sex: 'male', adoptable: false)

    @pet_applicant1 = PetApplicant.create!(pet: @pet1, applicant: @applicant1, adoption_status: 2)
    @pet_applicant2 = PetApplicant.create!(pet: @pet2, applicant: @applicant2, adoption_status: 0)
    @pet_applicant3 = PetApplicant.create!(pet: @pet2, applicant: @applicant1, adoption_status: 1)
    @pet_applicant3 = PetApplicant.create!(pet: @pet3, applicant: @applicant3, adoption_status: 0)

  end

  describe 'class methods' do
    it 'Lists shelters in reverse alphabetical order by name ' do
      shelters = Shelter.order_by_desc_name
      expected = [@shelter1, @shelter3, @shelter2]

      expect(shelters).to eq(expected)
    end

    it 'returns name and address only' do
      shelter = Shelter.information(@shelter1.id)

      expect(shelter[:name]).to eq(@shelter1.name)
      expect(shelter[:address]).to be_in(@shelter1.full_address)
      expect(shelter[:city]).to be_in(@shelter1.full_address)
      expect(shelter[:state]).to be_in(@shelter1.full_address)
      expect(shelter[:zip].to_s).to be_in(@shelter1.full_address)
    end

    it 'returns all shelters with a pending application and in alphabetical order' do
      shelters = Shelter.pending_applicants
      expected = [@shelter2, @shelter1]

      expect(shelters).to eq(expected)
      expect(shelters).not_to include(@shelter3)
    end
  end

  describe 'instance methods' do
    it 'returns the full address' do
      full_address = "#{@shelter1.address} #{@shelter1.city}, #{@shelter1.state} #{@shelter1.zip}"

      expect(@shelter1.full_address).to eq(full_address)
    end

    it 'returns average age of all adoptable pets' do
      average_age = @shelter2.average_age

      expect(average_age).to eq(2.0)
    end

    it 'returns count of all adoptable pets' do
      pet_count = @shelter1.adoptable_pet_count

      expect(pet_count).to eq(0)
    end

    it 'returns count of all adopted pets' do
      pet_count = @shelter1.adopted_pet_count

      expect(pet_count).to eq(2)
    end

    it 'returns all pets that hat have a pending application and have not been approved or rejected' do
      pets = @shelter1.action_required_pets
      expected = [@pet3]
      bad = [@pet1, @pet2]

      expect(pets).to eq(expected)
      expect(pets).not_to be_in(bad)
    end
  end
end
