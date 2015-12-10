class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :set_global_search_variable

  def set_global_search_variable
    @q = Article.ransack(params[:q])
  end

  def full_path(path)
    url = 'http://staging.don.cps.im.dendai.ac.jp'
    File.join(url, path)
  end
end
