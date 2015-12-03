class UploaderController < ApplicationController
  def index
  end

  def form
  end

  def upload
    @upload_file = UploadFile.new(upload_file_params)
    @upload_file.save
    redirect_to action: 'index'
  end

  def download
    @upload_file = UploadFile.find(params[:id].to_i)
    filepath = @upload_file.file.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @upload_file.file.url.gsub(/.*\//,''), :length => stat.size)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_file_params
      params.require(:upload_file).permit(:name, :file)
    end
end
