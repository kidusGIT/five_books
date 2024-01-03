Rails.application.routes.draw do
  get 'cart/index'
  devise_for :users
  resources :books

  # GET cart/
  get 'cart/', to: "cart#index", as: :carts

  # GET carts/sold
  get 'cart/sold', to: "cart#sold", as: :sold

  # GET books/cart/add/:id
  get 'cart/buy_book/:id', to: "cart#buy_book", as: :buy_book

  # GET carts/remove
  delete 'cart/return_book/:id', to: "cart#return_book", as: :return_book

  # GET carts/api/
  get 'carts/api', to: "cart#carts_api"

  # GET books/api/books/all
  get 'books/api/books/all', to: "books#getAllBooks"

  # GET /books/my/uploads
  get '/books/my/uploads', to: "books#uploads", as: :uploads

  root "books#index"
end
