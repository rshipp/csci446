json.array!(@pet_lists) do |pet_list|
  json.extract! pet_list, :id
  json.url pet_list_url(pet_list, format: :json)
end
