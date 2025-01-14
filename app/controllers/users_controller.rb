class UsersController < ApplicationController
   before_action :authenticate_user!, except: [:top]
   before_action :is_matching_login_user, only: [:edit, :update]
  
  def show 
    @book= Book.new
    @user = User.find(params[:id])
    @books = @user.books
   
  end

  def edit
    @user=User.find(params[:id])
  end

  def index
    @users = User.all 
     @book = Book.new
  end

  def create
     book = Book.new(book_params)
     book.user_id = current_user.id
     book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(book.id)
  end

  def update
      @user =User.find(params[:id])
  if  @user.update(user_params)
      flash[:notice] = "You have update user successfully."
      redirect_to user_path(@user.id)
  else
      @users = User.all 
      render :edit
  end
  end

private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_session_path
    end
  end
end