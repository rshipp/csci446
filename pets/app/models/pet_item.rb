class PetItem < ActiveRecord::Base
  belongs_to :pet
  belongs_to :pet_list
end
