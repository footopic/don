module API
  module V1
    class Comments < Grape::API
      include Grape::Kaminari

      resource :comments do

        # GET /api/v1/comments/create
        desc 'Get comment'
        params do
          requires :comment_id, type: Integer, desc: 'Comment Id.'
        end
        get do
          with = Entity::V1::CommentDetailEntity
          present Comment.find(params[:comment_id]), with: with
        end

        # POST /api/v1/comments/create
        desc 'Create comments'
        params do
          requires :article_id, type: Integer, desc: 'Article Id.'
          requires :user_id, type: Integer, desc: 'User Id.'
          requires :text, type: String, desc: 'Comment text.'
        end
        post 'create' do
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
