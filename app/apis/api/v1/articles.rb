module API
  module V1
    class Articles < Grape::API
      resource :articles do
        formatter :json, Grape::Formatter::Jbuilder


        # GET /api/v1/articles
        desc 'Get articles'
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include article details info.'
        end
        get '/' do
          with = Entity::V1::ArticleEntity
          if params[:include_details]
            with = Entity::V1::ArticleDetailEntity
          end
          present Article.all, with: with
        end

        # GET /api/v1/articles/show
        desc 'Get article'
        params do
          requires :id, type: Integer, desc: 'Article id.'
        end
        get '/show' do
          with = Entity::V1::ArticleDetailEntity
          present Article.find(params[:id]), with: with
        end

      end
    end
  end
end
