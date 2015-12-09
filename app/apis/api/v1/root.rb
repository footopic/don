module API
  module V1
    class Root < Grape::API
      version :v1
      format :json

      mount API::V1::UploadFiles
      mount API::V1::Articles
      mount API::V1::Users
      mount API::V1::Templates
    end
  end
end
