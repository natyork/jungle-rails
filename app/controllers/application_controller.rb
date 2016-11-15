class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :log_and_clear_emails
  def log_and_clear_emails
    if ActiveMailer::Base.delivery_method == :test
      ActiveMailer::Base.deliveries.each { |d| Rails.logger.debug(d) }
      ActiveMailer::Base.deliveries.clear
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
       current_user != nil
  end
  helper_method :logged_in?

  def authorize
    redirect_to '/login' unless current_user
  end

  private

  def cart
    # value = cookies[:cart] || JSON.generate({})
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end
