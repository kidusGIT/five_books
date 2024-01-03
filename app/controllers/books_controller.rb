class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy buy_book remove_book ]

  before_action :authenticate_user!, except: %i[ index show getAllBooks ]
  # before_action :correct_user, only: %i[ edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all.with_attached_image
  end

  # books/cart/add/:id
  def buy_book
    puts "add book #{@book.title}"
    @cart = Cart.new(user_id: current_user.id, book_id: params[:id])
    respond_to do |format|
      if @cart.save
        @book.update_column(:is_sold, true)
        format.html { render :buy_book }
      end
    end
  end

  # books/cart/remove/:id
  def remove_book
    puts "remove book #{@book.title}"
    @cart = Cart.where(book_id: @book.id)
    @cart.destroy!
    @book.update_column(:is_sold, false)
  end

  # GET books/api/books/all
  def getAllBooks
    @books = []
    if params[:search].present?
      search = params[:search]
      if search == ""
        @books = get_books
      else
        @books = Book.where(is_sold: false).where('title Like ? OR author Like ?', "%#{search}%", "%#{search}%" ).with_attached_image
      end
    else
      @books = get_books
    end
    render json: @books.map { |book|
        if book.image.attached?
          book.as_json.merge({ image: url_for(book.image) })
        else
          book.as_json.merge({ image: :null })
        end
    }
  end

  def get_books
    @books = Book.where(is_sold: false).with_attached_image
  end

  # getting

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /books/my/uploads
  def uploads
    if params[:query].present?
      if params[:query] == 'sold'
        @books = Book.where(user_id: current_user.id).where(is_sold: true)
        elsif params[:query] == 'not-sold'
        @books = Book.where(user_id: current_user.id).where(is_sold: false)

      elsif params[:query] == 'all-books'
        @books = Book.where(user_id: current_user.id)
      end
    else
      @books = Book.where(user_id: current_user.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :author, :price, :genre, :year, :image, :user_id)
    end
end
