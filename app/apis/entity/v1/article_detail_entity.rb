module Entity
  module V1
    class ArticleDetailEntity < ArticleEntity
      expose :histories, using: HistoryEntity
      expose :comments, using: CommentEntity
      expose :star_count_list, using: StarValueEntity
    end
  end
end
