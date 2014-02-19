json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :breed, :age, :shots, :notes, :image_url
  json.url pet_url(pet, format: :json)
end
