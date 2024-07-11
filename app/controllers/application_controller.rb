class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end


  def authenticate_user!
    redirect_to signin_path, alert: "You must be signed in to access this page." unless Current.user.present?
  end
end
