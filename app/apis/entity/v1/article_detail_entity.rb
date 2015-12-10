module Entity
  module V1
    class ArticleDetailEntity < ArticleEntity
      expose :comments, using: CommentEntity do |article|
        article.comments
      end
    end
  end
end
