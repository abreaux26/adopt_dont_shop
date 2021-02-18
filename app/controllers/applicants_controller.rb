class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

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
    @applicant = Applicant.find(params[:applicant_id])
    pet = Pet.find(params[:adopt_pet_id])
    new_pet_applicant = PetApplicant.create(pet: pet, applicant: @applicant)
    if new_pet_applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      flash[:notice] = new_pet_applicant.errors.full_messages
      render :show
    end
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
