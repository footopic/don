module Entity
  module V1
    class ArticleDetailEntity < ArticleEntity
      expose :comments, using: CommentEntity do |article|
        article.comments
      end
      expose :star_count_list, using: StarValueEntity
    end
  end
end
