class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def default_url_options(options = {})
    { lang: I18n.locale }.merge(options)
  end

  private

  def not_authenticated
    redirect_to login_path, alert: t('common.alert_login')
  end

  def set_locale
    I18n.locale = current_user&.locale ||
                  params[:lang] ||
                  http_accept_language.preferred_language_from(I18n.available_locales)
  end
end
