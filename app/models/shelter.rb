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
    joins(pets: [{pet_applicants: :applicant}]).where(applicants: { status: :pending })
  end
end
