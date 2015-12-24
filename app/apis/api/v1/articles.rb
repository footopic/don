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
        desc 'Get articles comp list'
        params do
          optional :q, type: String, desc: 'Fragment of articleId, articleTitle.'
        end
        get :comp do
          if params.key? :q && params[:q] == ''
            Article.select(:id, :title).order('id DESC').limit(10)
          else
            id_like = "#{params[:q]}%"
            title_like = "%#{params[:q]}%"
            Article.select(:id, :title).order('id DESC').where('id LIKE ? or title LIKE ?', id_like, title_like).limit(10)
          end
        end

        # POST /api/v1/articles/create
        desc 'Create articles'
        params do
          requires :user_id, type: Integer, desc: 'User Id.'
          requires :title, type: String, desc: 'Title.'
          requires :text, type: String, desc: 'Text.'
          optional :status, default: :limit, type: String, desc: 'Status [:publish, :limit, :wip]. default: :limit'
          optional :tag_list, type: String, desc: 'TagList separated ",". (ex. "hoge,fuga,piyo".'
          optional :notice, type: Boolean, desc: 'Do Notice with post.'
        end
        post :create do
          user = User.find(params[:user_id])
          article = user.articles.create(params.slice(:title, :text, :status, :tag_list, :notice).to_hash)
          with = Entity::V1::ArticleDetailEntity
          present article, with: with
        end
      end
    end
  end
end
