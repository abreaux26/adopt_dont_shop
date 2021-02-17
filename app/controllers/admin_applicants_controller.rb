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
    # binding.pry
    have_pending_records = @applicant.pet_applicants.any? { |pet_applicant| pet_applicant.pending? }
    if !have_pending_records
      if PetApplicant.all_approved?(@applicant.id)
        @applicant.update(status: 'accepted')
        @applicant.save
      else
        @applicant.update(status: 'rejected')
        @applicant.save
      end
      
      if @applicant.accepted?
        @applicant.pets.update(adoptable: false)
      end
    end
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
