class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_global_search_variable

  def set_global_search_variable
    @q = Article.ransack(params[:q])
  end
end
