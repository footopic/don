module API
  module V1
    class Root < Grape::API
      version :v1
      format :json

      mount API::V1::UploadFiles
    end
  end
end
