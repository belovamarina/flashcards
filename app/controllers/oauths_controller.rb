class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)
      redirect_back_or_to root_path, notice: t('.notice', provider: provider.titleize)
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_back_or_to root_path, notice: t('.notice', provider: provider.titleize)
      rescue => e
        redirect_back_or_to root_path, alert: t('.alert', provider: provider.titleize, error: e.message)
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
