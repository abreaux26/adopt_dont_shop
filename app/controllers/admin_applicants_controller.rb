class AdminApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
    @pet_applicants = @applicant.pet_applicants.includes(:pet)
  end

  def update
    pet_id = params[:pet_id]
    applicant_id = params[:applicant_id]
    pet_applicant = PetApplicant.find_by(pet_id, applicant_id)
    pet_applicant.update(pet_applicant_params)
    pet_applicant.save
    if PetApplicant.all_approved?(applicant_id)
      applicant = Applicant.find(applicant_id)
      applicant.update(status: 'Accepted')
      applicant.save
    else
      applicant = Applicant.find(applicant_id)
      applicant.update(status: 'Rejected')
      applicant.save
    end
    redirect_to "/admin/applicants/#{applicant_id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
