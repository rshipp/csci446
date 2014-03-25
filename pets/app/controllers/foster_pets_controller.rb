class FosterPetsController < ApplicationController
  before_action :set_foster_pet, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_pet_id

  # GET /foster_pets
  # GET /foster_pets.json
  def index
    @foster_pets = FosterPet.all
  end

  # GET /foster_pets/1
  # GET /foster_pets/1.json
  def show
  end

  # GET /foster_pets/new
  def new
    @foster_pet = FosterPet.new
  end

  # GET /foster_pets/1/edit
  def edit
  end

  # POST /foster_pets
  # POST /foster_pets.json
  def create
    pet = Pet.find(params[:foster_pet][:pet_id])
    @foster_pet = FosterPet.new(pet: pet)

    respond_to do |format|
      if @foster_pet.save
        format.html { redirect_to @foster_pet, notice: 'Foster pet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @foster_pet }
      else
        format.html { render action: 'new' }
        format.json { render json: @foster_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foster_pets/1
  # PATCH/PUT /foster_pets/1.json
  def update
    respond_to do |format|
      if @foster_pet.update(foster_pet_params)
        format.html { redirect_to @foster_pet, notice: 'Foster pet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @foster_pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foster_pets/1
  # DELETE /foster_pets/1.json
  def destroy
    @foster_pet.destroy
    respond_to do |format|
      format.html { redirect_to foster_pets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foster_pet
      @foster_pet = FosterPet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foster_pet_params
      params.require(:foster_pet).permit(:pet_id)
    end

    def invalid_pet_id
      logger.error "Attempt to access invalid pet id #{params[:id]}"
      redirect_to adopt_url, notice: 'Invalid pet id'
    end
end
