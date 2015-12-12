module API
  module V1
    class Articles < Grape::API
      include Grape::Kaminari

      resource :articles do

        # GET /api/v1/articles
        desc 'Get articles'
        paginate per_page: 10, max_per_page: 20, offset: 0
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include article details info.'
        end
        get do
          with = Entity::V1::ArticleEntity
          if params[:include_details]
            with = Entity::V1::ArticleDetailEntity
          end
          present paginate(Article.all), with: with
        end

        # GET /api/v1/articles/recent
        desc 'Get articles'
        paginate per_page: 10, max_per_page: 20, offset: 0
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include article details info.'
        end
        get :recent do
          with = Entity::V1::ArticleEntity
          if params[:include_details]
            with = Entity::V1::ArticleDetailEntity
          end
          present paginate(Article.order('id DESC')), with: with
        end

        # GET /api/v1/articles/show
        desc 'Get article'
        params do
          requires :id, type: Integer, desc: 'Article id.'
        end
        get :show do
          with = Entity::V1::ArticleDetailEntity
          present Article.find(params[:id]), with: with
        end

      end
    end
  end
end
