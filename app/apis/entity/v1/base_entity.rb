module Entity
  module V1
    class BaseEntity < Grape::Entity
      expose :id
      expose :created_at
      expose :updated_at
    end
  end
end
