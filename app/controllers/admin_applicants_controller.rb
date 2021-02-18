class AdminApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
    @pet_applicants = @applicant.pet_applicants.includes(:pet)
  end

  def update
    @pet = Pet.find(params[:pet_id])
    @applicant = Applicant.find(params[:applicant_id])
    pet_applicant = PetApplicant.find_by(@pet.id, @applicant.id)
    pet_applicant.update(pet_applicant_params)
    pet_applicant.save
    @applicant.change_status
    @applicant.change_pet_adoptable

    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
