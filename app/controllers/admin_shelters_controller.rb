class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_desc_name
    @pending_applicants = Shelter.pending_applicants
  end

  def show
    @shelter_information = Shelter.information(params[:shelter_id])
    @shelter = Shelter.find(params[:shelter_id])
  end
end
