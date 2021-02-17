class Applicant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  enum status: [:in_progress, :pending, :accepted, :rejected]

  def full_address
    "#{address} #{city}, #{state} #{zip}"
  end

  def any_pet_applicants_pending?
    pet_applicants.any? { |pet_applicant| pet_applicant.pending? }
  end

  def all_pet_applicants_approved?
    pet_applicants.all? { |pet_applicant| pet_applicant.approved? }
  end
end
