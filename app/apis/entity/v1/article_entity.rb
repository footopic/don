module Entity
  module V1
    class ArticleEntity < BaseEntity
      expose :title
      expose :text
      expose :user, using: UserEntity
      expose :tags do |article|
        article.tag_list
      end
      expose :star_counts do |article|
        article.stars.count
      end
    end
  end
end
