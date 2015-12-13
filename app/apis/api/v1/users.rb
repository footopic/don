module API
  module V1
    class Users < Grape::API
      include Grape::Kaminari

      resource :users do
        # GET /api/v1/users
        desc 'Get users'
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include user details info.'
        end
        get '/' do
          with = Entity::V1::UserEntity
          if params[:include_details]
            with = Entity::V1::UserDetailEntity
          end
          users = User.all
          present users, with: with
        end

        # GET /api/v1/users/show
        desc 'Show a user'
        params do
          optional :user_id, type: Integer, desc: 'User id.'
          optional :uid, type: String, desc: 'Omni uid.'
          exactly_one_of :user_id, :uid
        end
        get '/show' do
          with = Entity::V1::UserDetailEntity
          if params[:user_id]
            present User.find(params[:user_id]), with: with
          else
            user = User.find_by(uid: params[:uid], provider: 'google_oauth2')
            present user, with: with
          end
        end
      end
    end
  end
end
