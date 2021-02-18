class AddUniqueIndexToPetApplicants < ActiveRecord::Migration[5.2]
  def change
    add_index :pet_applicants, [:pet_id, :applicant_id], unique: true
  end
end
