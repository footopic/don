module API
  module V1
    class Root < Grape::API
      version :v1
      format :json

      mount API::V1::UploadFiles
      mount API::V1::Articles
      mount API::V1::Users
      mount API::V1::Templates

      add_swagger_documentation base_path: '/api',
                                api_version: 'v1',
                                hide_documentation_path: true
    end
  end
end
