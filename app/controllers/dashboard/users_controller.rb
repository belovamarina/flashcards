module Dashboard
  class UsersController < ApplicationController
    before_action :set_user, :check_user, only: %i[show edit update destroy]

    def index; end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        auto_login(@user)
        redirect_to @user
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to :back
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to root_path
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_deck_id, :locale)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def check_user
      return if current_user == @user
      render status: :forbidden, text: 'Вам сюда нельзя'
    end
  end
end
