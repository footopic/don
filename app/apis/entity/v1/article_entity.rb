module Entity
  module V1
    class ArticleEntity < Grape::Entity
      expose :id
      expose :title
      expose :text
      expose :user, using: Entity::V1::UserEntity
    end

    class ArticleDetailEntity < ArticleEntity
      expose :comments do |article|
        article.comments
      end
    end
  end
end
