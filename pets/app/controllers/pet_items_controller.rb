class PetItemsController < ApplicationController
  include CurrentPetList
  before_action :set_pet_list, only: [:create]
  before_action :set_pet_item, only: [:show, :edit, :update, :destroy]

  # GET /pet_items
  # GET /pet_items.json
  def index
    @pet_items = PetItem.all
  end

  # GET /pet_items/1
  # GET /pet_items/1.json
  def show
  end

  # GET /pet_items/new
  def new
    @pet_item = PetItem.new
  end

  # GET /pet_items/1/edit
  def edit
  end

  # POST /pet_items
  # POST /pet_items.json
  def create
    pet = Pet.find(params[:pet_id])
    @pet_item = @pet_list.add_pet(pet.id) #pet_items.build(pet: pet) #PetItem.new(pet_item_params)

    respond_to do |format|
      if @pet_item.save
        format.html { redirect_to @pet_item.pet_list }
        format.json { render action: 'show', status: :created, location: @pet_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @pet_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pet_items/1
  # PATCH/PUT /pet_items/1.json
  def update
    respond_to do |format|
      if @pet_item.update(pet_item_params)
        format.html { redirect_to @pet_item, notice: 'Pet item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pet_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pet_items/1
  # DELETE /pet_items/1.json
  def destroy
    @pet_item.destroy
    respond_to do |format|
      format.html { redirect_to pet_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet_item
      @pet_item = PetItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_item_params
      params.require(:pet_item).permit(:pet_id)
    end
end
