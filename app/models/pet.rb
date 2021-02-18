class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applicants
  has_many :applicants, through: :pet_applicants
  validates_presence_of :name, :description, :approximate_age, :sex

  validates :approximate_age, numericality: {
              greater_than_or_equal_to: 0
            }

  enum sex: [:female, :male]

  def self.partial_search(input)
    where("name ILIKE ?", "%#{input}%")
  end

  def applicants_pending
    applicants.pending
  end
end
