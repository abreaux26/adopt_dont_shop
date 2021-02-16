class PetApplicant < ApplicationRecord
  validates_presence_of :pet_id, :applicant_id
  belongs_to :pet
  belongs_to :applicant

  enum adoption_status: ['Rejected', 'Approved']

  def self.find_by(pet_id, applicant_id)
    where(pet: pet_id).where(applicant: applicant_id).take
  end

  def self.all_approved?(applicant_id)
    where(applicant: applicant_id).all? do |pet_applicant|
      pet_applicant.adoption_status == 'Approved'
    end
  end
end
