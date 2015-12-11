class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/users.rb)
    # @user = User.from_omniauth(request.env['omniauth.auth'])

    auth_params = request.env['omniauth.auth']
    filter_mail_domain = 'cps.im.dendai.ac.jp'
    unless auth_params.info.email.split('@')[1] == filter_mail_domain
      return redirect_to articles_url, flash: { error: 'CPS メールアドレスのアカウントが必要です' }
    end
    @user = User.where(provider: auth_params[:provider], uid: auth_params[:uid]).first

    if @user.nil?
      User.create(
          uid:         auth_params[:uid],
          provider:    auth_params[:provider],
          name:        auth_params[:info][:name],
          screen_name: auth_params[:info][:email].gsub(/@.*/, '')
      )
      @user = User.last
      @user.save_icon(File.open(Rails.root.join('app', 'assets', 'images', 'noimg.png')))
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
