class PetApplicant < ApplicationRecord
  validates_presence_of :pet_id, :applicant_id
  belongs_to :pet
  belongs_to :applicant

  def self.find_by(pet_id, applicant_id)
    where(pet: pet_id).where(applicant: applicant_id).take
  end

  def self.pet_applicant_approved?(pet_id, applicant_id)
    where(pet: pet_id).where(applicant: applicant_id).take.is_pet_approved
  end
end
