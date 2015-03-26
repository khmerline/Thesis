json.array!(@catagories) do |catagory|
  json.extract! catagory, :id, :cat_type
  json.url catagory_url(catagory, format: :json)
end
