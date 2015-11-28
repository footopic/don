class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.where(user_params.slice(:provider, :uid).to_h).first
    if @user.nil?
      @user = User.create(user_params)
    end

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  private
  def user_params
    if @user_params
      return @user_params
    end
    auth_params = request.env["omniauth.auth"]
    params = auth_params.slice(:provider, :uid).to_h
    @user_params = params.merge({
      screen_name: auth_params[:info][:nickname],
      name: auth_params[:info][:name]
    })
  end
end
