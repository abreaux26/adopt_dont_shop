class ChangeAdoptionStatusDefaultFromPetApplicants < ActiveRecord::Migration[5.2]
  def change
    change_column_default :pet_applicants, :adoption_status, nil
  end
end
