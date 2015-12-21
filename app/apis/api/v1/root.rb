module API
  module V1
    class Root < Grape::API
      version :v1
      format :json

      http_basic do |user, password|
        basic_config = Rails.application.secrets.basic
        { basic_config['user'] => basic_config['pass'] }[user] == password
      end

      mount API::V1::Images
      mount API::V1::Articles
      mount API::V1::Users
      mount API::V1::Comments
      mount API::V1::Tags

      add_swagger_documentation base_path: '/api',
                                api_version: 'v1',
                                hide_documentation_path: true
    end
  end
end
