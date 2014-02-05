json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :breed, :image_url, :age, :shots, :notes
  json.url pet_url(pet, format: :json)
end
