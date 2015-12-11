# ネストガンガン上がってんだけどこの書き方合ってるのか？

module API
  module V1
    class Images < Grape::API
      resource :images do

        # GET /api/v1/images/upload
        desc 'Upload image file'
        params do
          requires :name, type: String, desc: 'File name.'
          requires :file, type: Rack::Multipart::UploadedFile, desc: 'Image file'
        end
        post :upload do
          Image.create(name: params.name, file: params.file)
        end
      end
    end
  end
end