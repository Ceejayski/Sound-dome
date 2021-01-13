class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :priority_categories, :already_liked?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username])
  end

  def priority_categories(limit = nil)
    Category.high_priority(limit)
  end

  def already_voted?
    Vote.where(user_id: current_user.id, article_id:
    params[:article_id]).exists?
  end
end
