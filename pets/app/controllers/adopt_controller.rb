class AdoptController < ApplicationController
  def index
    @pets = Pet.order(:title)
  end
end
