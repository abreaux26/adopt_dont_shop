class AdminApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
  end

  def update
    pet_id = params[:pet_id]
    applicant_id = params[:applicant_id]
    pet_applicant = PetApplicant.find_by(pet_id, applicant_id)
    pet_applicant.update(pet_applicant_params)
    pet_applicant.save
    redirect_to "/admin/applicants/#{applicant_id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
