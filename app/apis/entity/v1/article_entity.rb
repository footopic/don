module Entity
  module V1
    class ArticleEntity < Grape::Entity
      expose :id
      expose :title
      expose :text
      expose :user, using: Entity::V1::UserEntity
    end
  end
end
