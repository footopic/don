module Entity
  module V1
    class UserCompEntity < Grape::Entity
      expose :id
      expose :screen_name
      expose :thumb_url do |user| user.image.thumb.url end
    end
  end
end
