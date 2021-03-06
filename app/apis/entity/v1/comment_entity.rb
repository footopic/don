module Entity
  module V1
    class CommentEntity < BaseEntity
      expose :text
      expose :user, using: UserSimpleEntity
    end
  end
end
