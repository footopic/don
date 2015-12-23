module API
  module V1
    class Users < Grape::API
      include Grape::Kaminari

      resource :users do

        before_validation do
          @with = Entity::V1::UserEntity
          if params.key? :include_details and params[:include_details] == "true"
            @with = Entity::V1::UserDetailEntity
          end
        end
        # GET /api/v1/users
        desc 'Get users'
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include user details info.'
        end
        get '/' do
          users = User.includes(:articles)
          present users, with: @with
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
          user_pre = User.includes(articles: [:tags, :comments, :histories, :stars]).order('articles.updated_at')
          if params[:user_id]
            user = user_pre.find(params[:user_id])
          else
            user = user_pre.find_by(uid: params[:uid], provider: 'google_oauth2')
          end
          present user, with: with
        end

        # GET /api/v1/users/comp
        desc 'Get users comp list'
        params do
          optional :q, type: String, desc: 'Fragment of userScreen_name.'
        end
        get :comp do
          if params.key? :q && params[:q] == ''
            users = User.limit(10)
          else
            users = User.where('screen_name LIKE ?', "%#{params[:q]}%").limit(10)
          end
          present users, with: Entity::V1::UserCompEntity
        end
      end
    end
  end
end
