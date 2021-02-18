class PetApplicant < ApplicationRecord
  validates_presence_of :pet_id, :applicant_id

  belongs_to :pet
  belongs_to :applicant

  enum adoption_status: [:pending, :rejected, :approved]

  def self.find_by(pet_id, applicant_id)
    where(pet: pet_id).where(applicant: applicant_id).take
  end

  def self.any_pending?(applicant_id)
    where(applicant_id: applicant_id).where(adoption_status: :pending).any?
  end

  def self.all_approved?(applicant_id)
    where(applicant_id: applicant_id).all? { |pet_applicant| pet_applicant.approved? }
  end
end
