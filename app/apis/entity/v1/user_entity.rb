module Entity
  module V1
    class UserEntity < Grape::Entity
      expose :id
      expose :screen_name
      expose :provider
      expose :uid
      expose :name
      expose :image do
        expose :url do |user| user.image.url end
        expose :thumb_url do |user| user.image.thumb.url end
      end

      expose :article_count do |user|
        user.articles.count
      end
    end
  end
end
