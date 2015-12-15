module API
  module V1
    class Tags < Grape::API
      include Grape::Kaminari

      resource :tags do
        # POST /api/v1/tags
        desc 'Get tags'
        params do
          requires :article_id, type: Integer, desc: 'Article Id.'
          requires :tag, type: String, desc: 'Tag.'
        end
        post do
          article = Article.find(params[:article_id])
          article.tag_list << params[:tag]
          article.save
          article.tag_list
        end

        # DELETE /api/v1/tags
        desc 'Delete tags'
        params do
          requires :article_id, type: Integer, desc: 'Article Id.'
          requires :tag, type: String, desc: 'Tag.'
        end
        delete do
          article = Article.find(params[:article_id])
          article.tag_list.delete(params[:tag])
          article.save
          article.tag_list
        end
      end
    end
  end
end
