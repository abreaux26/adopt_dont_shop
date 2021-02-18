class PetApplicantsController < ApplicationController
  def create
    @applicant = Applicant.find(params[:applicant_id])
    pet = Pet.find(params[:adopt_pet_id])
    new_pet_applicant = PetApplicant.create(pet: pet, applicant: @applicant)
    if new_pet_applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      flash[:notice] = new_pet_applicant.errors.full_messages
      render 'applicants/show'
    end
  end
end
