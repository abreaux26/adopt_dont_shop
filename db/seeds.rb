# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@shelter1 = Shelter.create!(name: 'Shady Shelter', address: '123 Shady Ave', city: 'Denver', state: 'CO', zip: 80011)
@shelter2 = Shelter.create!(name: 'Silly Shelter', address: '123 Silly Ave', city: 'Longmont', state: 'CO', zip: 80012)
@shelter3 = Shelter.create!(name: 'Shell Shelter', address: '102 Shelter Dr.', city: 'Commerce City', state: 'CO', zip: 80022)

@pet1 = @shelter1.pets.create!(image:'', name: 'Thor', description: 'dog', approximate_age: 2, sex: 'male')
@pet2 = @shelter2.pets.create!(image:'', name: 'Athena', description: 'cat', approximate_age: 3, sex: 'female')
@pet3 = @shelter1.pets.create!(image:'', name: 'Zeus', description: 'dog', approximate_age: 4, sex: 'male')

@applicant1 = Applicant.create!(name: 'Angel', address: '123 Street', city: 'Conway', state: 'AR', zip: 72034)
@applicant2 = Applicant.create!(name: 'Chris', address: '456 Street', city: 'Denver', state: 'CO', zip: 80011)
@applicant3 = Applicant.create!(name: 'Amber', address: '789 Street', city: 'Longmont', state: 'CO', zip: 80012)
@applicant4 = Applicant.create!(name: 'Levi', address: '101 Street', city: 'Commerce City', state: 'CO', zip: 80022)

PetApplicant.create!(pet: @pet1, applicant: @applicant1)
PetApplicant.create!(pet: @pet1, applicant: @applicant2)
