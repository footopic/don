module Entity
  module V1
    class UserDetailEntity < UserEntity
      expose :recent_articles, using: ArticleEntity do |user|
        user.recent_articles
      end
    end
  end
end
