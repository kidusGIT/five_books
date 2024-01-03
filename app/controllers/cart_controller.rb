class CartController < ApplicationController
  before_action :authenticate_user!

  def index
    @carts = Cart.where(user_id: current_user.id).joins(:book).includes(:book)
  end

  def sold
    @carts = Cart.joins(:book, :user).includes(:book, :user).where(books: { user_id: current_user.id })
  end

  def buy_book
    @book = Book.find(params[:id])
    @cart = Cart.new(user_id: current_user.id, book_id: params[:id])
    respond_to do |format|
      if @cart.save
        @book.update_column(:is_sold, true)
        format.html { render :buy_book }
      end
    end
  end

  def return_book
    @cart = Cart.joins(:book, :user).includes(:book, :user).where(book_id: params[:id]).where(user_id: current_user.id).first
    @cart.destroy!
    @book = Book.find(params[:id])
    @book.update_column(:is_sold, false)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@cart.book)}_item") }
    end
  end

  def carts_api
    @carts = Cart.where(user_id: 4).joins(:book).includes(:book)
    render json: @carts.to_json(include: [:book, :user])
  end
end
