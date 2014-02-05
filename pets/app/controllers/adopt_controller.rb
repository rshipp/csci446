class AdoptController < ApplicationController
  def index
    @pets = Pet.all
  end
end
