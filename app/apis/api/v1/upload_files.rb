# ネストガンガン上がってんだけどこの書き方合ってるのか？

module API
  module V1
    class UploadFiles < Grape::API
      resource :upload_files do

        # GET /api/v1/upload_files/upload
        desc 'Upload image file'
        params do
          requires :name, type: String, desc: 'File name.'
          requires :file, type: Rack::Multipart::UploadedFile, desc: 'Image file'
        end
        post :upload do
          UploadFile.create(name: params.name, file: params.file)
        end
      end
    end
  end
end