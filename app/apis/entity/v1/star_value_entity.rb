module Entity
  module V1
    class StarValueEntity < Grape::Entity
      expose :user, using: UserSimpleEntity
      expose :count
    end
  end
end
