module Entity
  module V1
    class ArticleEntity < BaseEntity
      expose :title
      expose :text
      expose :user, using: UserEntity
      expose :tags, as: :tag_list
      expose :star_counts do |article|
        article.stars.count
      end
    end
  end
end
