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
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to "/applicants/#{@applicant.id}"
    else
      flash[:notice] = @applicant.errors.full_messages
      render :new
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
