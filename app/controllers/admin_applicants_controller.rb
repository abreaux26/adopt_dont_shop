class AdminApplicantsController < ApplicationController
  def applicant_show
    @applicant = Applicant.find(params[:applicant_id])
    @pet_applicants = @applicant.pet_applicants.includes(:pet)
  end

  def update
    @pet = Pet.find(params[:pet_id])
    @applicant = Applicant.find(params[:applicant_id])
    pet_applicant = PetApplicant.find_by(@pet.id, @applicant.id)
    pet_applicant.update(pet_applicant_params)
    pet_applicant.save
    if !PetApplicant.any_pending?(@applicant.id)
      if PetApplicant.all_approved?(@applicant.id)
        @applicant.update(status: 'accepted')
        @applicant.save
      else
        @applicant.update(status: 'rejected')
        @applicant.save
      end

      if @applicant.accepted?
        update_pets = @applicant.pets.update(adoptable: false)
        update_pets.each(&:save)
      end
    end
    redirect_to "/admin/applicants/#{@applicant.id}"
  end

  def shelter_index
    @shelters = Shelter.order_by_desc_name
    @pending_applicants = Shelter.pending_applicants
  end

  def shelter_show
    @shelter_information = Shelter.information(params[:shelter_id])
    @shelter = Shelter.find(params[:shelter_id])
  end

  private

  def pet_applicant_params
    params.permit(:pet_id, :applicant_id, :adoption_status)
  end
end
