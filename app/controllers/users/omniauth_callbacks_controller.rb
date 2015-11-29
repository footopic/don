class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter

    @user = User.where(provider: user_params[:provider], uid: user_params[:uid]).first
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

  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    # @user = User.from_omniauth(request.env['omniauth.auth'])

    auth_params = request.env['omniauth.auth']

    @user = User.where(provider: auth_params[:provider], uid: auth_params[:uid]).first

    if @user.nil?
      @user = User.create(
          uid:         auth_params[:uid],
          provider:    auth_params[:provider],
          name:        auth_params[:info][:name],
          screen_name: auth_params[:info][:email].gsub(/@.*/, '')
      )
    end

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', :kind => 'Google'
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  private

  def user_params
    if @user_params
      return @user_params
    end
    auth_params  = request.env['omniauth.auth']
    params       = auth_params.slice(:provider, :uid).to_h
    @user_params = params.merge(
        {
            screen_name: auth_params[:info][:nickname],
            name:        auth_params[:info][:name]
        }
    )
  end
end
