module API
  module V1
    class Comments < Grape::API
      include Grape::Kaminari

      resource :comments do

        # GET /api/v1/comments
        desc 'Get comments'
        paginate per_page: 10, max_per_page: 50, offset: 0
        get do
          with = Entity::V1::CommentDetailEntity
          comments = paginate(Comment.includes_details)
          present comments, with: with
        end

        # GET /api/v1/comments/recent
        desc 'Get comments recent'
        paginate per_page: 10, max_per_page: 50, offset: 0
        get :recent do
          with = Entity::V1::CommentDetailEntity
          comments = paginate(Comment.includes_details.order('id DESC'))
          present comments, with: with
        end

        # GET /api/v1/comments/show
        desc 'Get comment'
        params do
          requires :comment_id, type: Integer, desc: 'Comment Id.'
        end
        get :show do
          with = Entity::V1::CommentDetailEntity
          present Comment.includes_details.find(params[:comment_id]), with: with
        end

        # POST /api/v1/comments/create
        desc 'Create comments'
        params do
          requires :article_id, type: Integer, desc: 'Article Id.'
          requires :user_id, type: Integer, desc: 'User Id.'
          requires :text, type: String, desc: 'Comment text.'
        end
        post :create do
          article = Article.find(params[:article_id])
          comment = article.comments.create(
              user_id: params[:user_id],
              text: params[:text]
          )
          with = Entity::V1::CommentDetailEntity
          present comment, with: with
        end

      end
    end
  end
end
