module API
  module V1
    class Users < Grape::API
      resource :users do
        formatter :json, Grape::Formatter::Jbuilder

        # GET /api/v1/users
        desc 'Get users'
        params do
        end
        get '/' do
          User.all
        end

        # GET /api/v1/users/show
        desc 'Show a user'
        params do
          optional :user_id, type: Integer, desc: 'User id.'
          optional :uid, type: String, desc: 'Omni uid.'
          exactly_one_of :user_id, :uid
        end
        get '/show' do
          if params[:user_id]
            User.find(params[:user_id])
          else
            User.find_by(uid: params[:uid], provider: 'google_oauth2')
          end
        end
      end
    end
  end
end
