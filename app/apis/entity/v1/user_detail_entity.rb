module Entity
  module V1
    class UserDetailEntity < UserEntity
      expose :recent_articles, using: ArticleEntity do |user|
        user.articles.take(5)
      end
    end
  end
end
