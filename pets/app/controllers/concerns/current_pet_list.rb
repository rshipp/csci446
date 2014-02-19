module CurrentPetList
  extend ActiveSupport::Concern

  private

    def set_pet_list
      @pet_list = PetList.find(session[:pet_list_id])
    rescue ActiveRecord::RecordNotFound
      @pet_list = PetList.create
      session[:pet_list_id] = @pet_list.id
    end
end

