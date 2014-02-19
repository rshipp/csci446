class PetList < ActiveRecord::Base
  has_many :pet_items, dependent: :destroy
end
