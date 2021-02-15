class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:applicant_id])
    if params[:search]
      @pets = Pet.partial_search(params[:search])
    end
  end

  def new
  end

  def create
    applicant = Applicant.new(applicant_params)

    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      flash[:notice] = "Applicant not created: Required information missing."
      redirect_to "/applicants/new"
    end
  end

  def create_applicant_pet
    applicant = Applicant.find(params[:applicant_id])
    pet = Pet.find(params[:adopt_pet_id])
    new_applicant_pet = PetApplicant.create(pet: pet, applicant: applicant)
    new_applicant_pet.save
    redirect_to "/applicants/#{applicant.id}"
  end

  def update
    applicant = Applicant.find(params[:applicant_id])
    applicant.update(applicant_params)
    applicant.save
    redirect_to "/applicants/#{applicant.id}"
  end

  private

  def applicant_params
    params.permit(:name, :address, :city, :state, :zip, :good_home_description, :status)
  end
end
