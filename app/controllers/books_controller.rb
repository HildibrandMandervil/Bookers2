class BooksController < ApplicationController
 before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @new_book=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def edit
    @book=Book.find(params[:id])
  end

  def index
     @books=Book.all
     @book = Book.new
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
  if  @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
  else
     @books=Book.all
      render :index
  end
  end
  def update
      book =Book.find(params[:id])
  if  book.update(book_params)
      flash[:notice] = "You have update book successfully."
      redirect_to book_path(book.id)
  else
      @book=book
      render :edit
  end
  end

  def destroy
     @books=Book.all
     book=Book.find(params[:id])
     book.delete
     redirect_to '/books'
  end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_session_path
    end
  end
end
