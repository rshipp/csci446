class AdoptController < ApplicationController
  include CurrentPetList
  before_action :set_pet_list
  helper_method :sort_column, :sort_direction

  def index
    @pets = Pet.order(sort_column + " " + sort_direction)
  end

  def sort_column
    Pet.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
