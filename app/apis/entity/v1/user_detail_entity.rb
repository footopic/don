module Entity
  module V1
    class UserDetailEntity < UserEntity
      expose :recent_articles, using: ArticleEntity
    end
  end
end
