json.extract! book, :id, :title, :description, :author, :price, :genre, :year, :created_at, :updated_at
json.url book_url(book, format: :json)
