module API
  module V1
    class Articles < Grape::API
      include Grape::Kaminari

      resource :articles do

        before_validation do
          @with = Entity::V1::ArticleEntity
          if params.key? :include_details and params[:include_details] == "true"
            @with = Entity::V1::ArticleDetailEntity
          end
        end
        # GET /api/v1/articles
        desc 'Get articles'
        paginate per_page: 10, max_per_page: 20, offset: 0
        params do
          optional :include_details, type: Boolean, default: false, desc: '[DEPRECATED]Include article details info.'
        end
        get do
          articles = paginate(Article.includes(:tags, :comments, :user, :histories, :stars))
          present articles, with: @with
        end

        params do
          optional :order_new, type: Boolean, default: false, desc: 'Sorted by new.'
        end
        # GET /api/v1/articles/recent
        desc 'Get articles'
        paginate per_page: 10, max_per_page: 20, offset: 0
        params do
          optional :include_details, type: Boolean, default: false, desc: 'Include article details info.'
        end
        get :recent do
          order = 'updated_at DESC'
          if params[:order_new]
            order = 'id DESC'
          end
          articls = paginate(Article.includes(:tags, :comments, :user, :histories, :stars).order(order))
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

        # GET /api/v1/articles/comp
        desc 'Get articles'
        params do
          optional :num, type: Integer, desc: 'Fragment of articleId.'
        end
        get :comp do
          if params.key? :num && params[:num] == ''
            Article.select(:id, :title).order('id DESC').limit(10)
          else
            Article.select(:id, :title).order('id DESC').where("id like '#{params[:num]}%'").limit(10)
          end
        end
      end
    end
  end
end
