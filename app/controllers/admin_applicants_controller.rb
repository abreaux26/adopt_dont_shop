class AdminApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
    @pet_applicants = @applicant.pet_applicants.includes(:pet)
  end

  def update
    pet_id = params[:pet_id]
    @applicant = Applicant.find(params[:applicant_id])
    pet_applicant = PetApplicant.find_by(pet_id, @applicant.id)
    pet_applicant.update(pet_applicant_params)
    pet_applicant.save
    if PetApplicant.all_approved?(@applicant.id)
      @applicant.update(status: 'Accepted')
    else
      @applicant.update(status: 'Rejected')
    end
    @applicant.save
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
