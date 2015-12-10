module API
  module V1
    class Users < Grape::API
      resource :users do
        formatter :json, Grape::Formatter::Jbuilder

        # GET /api/v1/users
        desc 'Get users'
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include user details info.'
        end
        get '/' do
          with = API::Entities::User
          if params[:include_details]
            with = API::Entities::UserDetail
          end
          present User.all, with: with
        end

        # GET /api/v1/users/show
        desc 'Show a user'
        params do
          optional :user_id, type: Integer, desc: 'User id.'
          optional :uid, type: String, desc: 'Omni uid.'
          exactly_one_of :user_id, :uid
        end
        get '/show' do
          with = API::Entities::UserDetail
          if params[:user_id]
            present User.find(params[:user_id]), with: with
          else
            present User.find_by(uid: params[:uid], provider: 'google_oauth2'), with: with
          end
        end
      end
    end
  end

  module Entities
    class User < Grape::Entity
      expose :id
      expose :screen_name
      expose :provider
      expose :uid
      expose :name
      expose :image
      expose :article_count do |user| user.articles.count end
    end

    class UserDetail < User
      expose :recent_articles do |user| user.recent_articles end
    end
  end
end
