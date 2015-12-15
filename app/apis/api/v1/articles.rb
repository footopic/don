module API
  module V1
    class Articles < Grape::API
      include Grape::Kaminari

      params do
        optional :include_details, type: Boolean, default: false, desc: 'Include article details info.'
      end
      paginate per_page: 10, max_per_page: 20, offset: 0
      resource :articles do

        before_validation do
          if params.key? :include_details
            if params[:include_details]
              @with = Entity::V1::ArticleDetailEntity
            else
              @with = Entity::V1::ArticleEntity
            end
          end
        end
        # GET /api/v1/articles
        desc 'Get articles'
        get do
          articles = paginate(Article.all)
          present articles, with: @with
        end

        params do
          optional :order_new, type: Boolean, default: false, desc: 'Sorted by new.'
        end
        # GET /api/v1/articles/recent
        desc 'Get articles'
        get :recent do
          order = 'updated_at DESC'
          if params[:order_new]
            order = 'id DESC'
          end
          articls = paginate(Article.order(order))
          present articls, with: @with
        end

        # GET /api/v1/articles/show
        desc 'Get article'
        params do
          requires :id, type: Integer, desc: 'Article id.'
        end

        get :show do
          with = Entity::V1::ArticleDetailEntity
          article = Article.find(params[:id])
          present article, with: with
        end

      end
    end
  end
end
