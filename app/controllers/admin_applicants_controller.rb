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
    if PetApplicant.all_approved?(@applicant.id)
      @applicant.update(status: 'Accepted')
      @pet.update(adoptable: false)
    else
      @applicant.update(status: 'Rejected')
      @pet.update(adoptable: true)
    end
    @applicant.save
    @pet.save
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
