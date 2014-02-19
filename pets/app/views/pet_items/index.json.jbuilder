json.array!(@pet_items) do |pet_item|
  json.extract! pet_item, :id, :pet_id, :pet_list_id
  json.url pet_item_url(pet_item, format: :json)
end
