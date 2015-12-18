module Entity
  module V1
    class ArticleEntity < BaseEntity
      expose :title
      expose :text
      expose :user, using: UserSimpleEntity
      expose :tag_names, as: :tags
      expose :history_count do |a| a.histories.size end
      expose :comment_count do |a| a.comments.size end
      expose :star_count do |a| a.stars.size end
    end
  end
end
