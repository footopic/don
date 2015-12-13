module Entity
  module V1
    class UserSimpleEntity < UserEntity
      unexpose :created_at
      unexpose :updated_at
      unexpose :provider
      unexpose :name

      unexpose :article_count
    end
  end
end
