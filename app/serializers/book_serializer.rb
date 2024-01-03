class BookSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :author, :description, :genre, :price, :updated_at, :created_at, :year, :image_url
end
