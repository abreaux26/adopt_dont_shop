class Applicant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pet_applicants
  has_many :pets, through: :pet_applicants

  enum status: [:in_progress, :pending, :accepted, :rejected]

  def change_pet_adoptable
    pets.update(adoptable: false) if accepted?
  end

  def change_status
    if !pet_applicants.any_pending?(id)
      if pet_applicants.all_approved?(id)
        update(status: :accepted)
      else
        update(status: :rejected)
      end
    end
  end
end
