module Entity
  module V1
    class HistoryEntity < BaseEntity
      expose :user, using: UserSimpleEntity
    end
  end
end
