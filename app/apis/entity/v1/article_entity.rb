module Entity
  module V1
    class ArticleEntity < BaseEntity
      expose :title
      expose :text
      expose :user, using: UserEntity
      expose :tags, as: :tag_list
      expose :history_counts do |a| a.histories.count end
      expose :comment_counts do |a| a.comments.count end
      expose :star_counts do |a| a.stars.count end
    end
  end
end
