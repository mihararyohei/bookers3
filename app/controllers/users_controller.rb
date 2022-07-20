class UsersController < ApplicationController

  def index
    @book=Book.new
    @users=User.all
    @user=current_user
  end

  def show
    @user=User.find(params[:id])
    @book=Book.new
    # @books=Book.where(user_id:@user)
    @books=@user.books
  end

  def edit
    @user=User.find(params[:id])
    if @user==current_user
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]='Book was successfully updated.'
    redirect_to user_path(current_user.id)
    else
    @users=User.all
    render:edit
    end
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      # @user=current_user
      render:index
    end
  end

   private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(user_path) unless @user == current_user
  end
end
