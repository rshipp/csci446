class PetList < ActiveRecord::Base
  has_many :pet_items, dependent: :destroy

  def add_pet(pet_id)
    current_item = pet_items.find_by(pet_id: pet_id)
    # Only allow one of each pet - you can't adopt it twice.
    current_item = pet_items.build(pet_id: pet_id) unless current_item
    current_item
  end
end
