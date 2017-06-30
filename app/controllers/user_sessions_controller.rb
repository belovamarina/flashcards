class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:users, notice: t('.success'))
    else
      flash.now[:alert] = t('.alert')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('.logout')
  end
end
