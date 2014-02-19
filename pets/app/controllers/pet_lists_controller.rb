class PetListsController < ApplicationController
  before_action :set_pet_list, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_pet_list

  # GET /pet_lists
  # GET /pet_lists.json
  def index
    @pet_lists = PetList.all
  end

  # GET /pet_lists/1
  # GET /pet_lists/1.json
  def show
  end

  # GET /pet_lists/new
  def new
    @pet_list = PetList.new
  end

  # GET /pet_lists/1/edit
  def edit
  end

  # POST /pet_lists
  # POST /pet_lists.json
  def create
    @pet_list = PetList.new(pet_list_params)

    respond_to do |format|
      if @pet_list.save
        format.html { redirect_to @pet_list, notice: 'Pet list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pet_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @pet_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pet_lists/1
  # PATCH/PUT /pet_lists/1.json
  def update
    respond_to do |format|
      if @pet_list.update(pet_list_params)
        format.html { redirect_to @pet_list, notice: 'Pet list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pet_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pet_lists/1
  # DELETE /pet_lists/1.json
  def destroy
    @pet_list.destroy if @pet_list.id == session[:pet_list_id]
    session[:pet_list_id] = nil
    respond_to do |format|
      format.html { redirect_to adopt_url } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet_list
      @pet_list = PetList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pet_list_params
      params[:pet_list]
    end

    def invalid_pet_list
      logger.error "Attempt to access invalid pet list #{params[:id]}"
      redirect_to adopt_url, notice: 'Invalid pets list'
    end
end
