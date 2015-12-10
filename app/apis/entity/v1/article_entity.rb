module Entity
  module V1
    class ArticleEntity < BaseEntity
      expose :title
      expose :text
      expose :user, using: UserEntity
      expose :tags do |article|
        article.tag_list
      end
    end
  end
end
