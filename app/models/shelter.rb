class Shelter < ApplicationRecord
  has_many :pets
  has_many :pet_applicants, through: :pets
  has_many :applicants, through: :pet_applicants

  def self.order_by_desc_name
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.information(id)
    find_by_sql("SELECT name, address, city, state, zip FROM shelters WHERE id = #{id}").first
  end

  def self.pending_applicants
    joins(:pets)
    .joins(:pet_applicants)
    .joins(:applicants)
    .where('applicants.status = 1')
    .order('shelters.name')
    .distinct
  end

  def average_age
    pets.where(adoptable: :true).average(:approximate_age).to_f
  end

  def adoptable_pet_count
    pets.where(adoptable: :true).count
  end
end
