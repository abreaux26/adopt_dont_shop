class RenameIsPetApprovedFromPetApplicants < ActiveRecord::Migration[5.2]
  def change
    rename_column :pet_applicants, :is_pet_approved, :adoption_status
    change_column :pet_applicants, :adoption_status, :integer, using: 'adoption_status::integer'
    change_column_default :pet_applicants, :adoption_status, -1
  end
end
