module Entity
  module V1
    class UserEntity < Grape::Entity
      expose :id
      expose :screen_name
      expose :provider
      expose :uid
      expose :name
      expose :image
      expose :article_count do |user|
        user.articles.count
      end
    end

    class UserDetailEntity < UserEntity
      expose :recent_articles, using: Entity::V1::ArticleEntity do |user|
        user.recent_articles
      end
    end
  end
end
