module Entity
  module V1
    class CommentEntity < BaseEntity
      expose :text
      expose :user, using: UserEntity
    end
  end
end
