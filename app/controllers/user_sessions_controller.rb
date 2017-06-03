class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:users, notice: 'Успешно')
    else
      flash.now[:alert] = 'Неправильные почта и/или пароль'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Вы вышли'
  end
end
