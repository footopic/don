module Entity
  module V1
    class CommentDetailEntity < CommentEntity
      expose :article, using: ArticleEntity
      expose :user, using: UserEntity
    end
  end
end
