json.array!(@foster_pets) do |foster_pet|
  json.extract! foster_pet, :id, :pet_id
  json.url foster_pet_url(foster_pet, format: :json)
end
