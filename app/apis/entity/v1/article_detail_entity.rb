module Entity
  module V1
    class ArticleDetailEntity < ArticleEntity
      expose :comments do |article|
        article.comments
      end
    end
  end
end
