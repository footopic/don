class UploaderController < ApplicationController
  def index
  end

  def form
  end

  def upload
    @image = Image.new(image_params)
    @image.save
    redirect_to action: 'index'
  end

  def download
    @image = Image.find(params[:id].to_i)
    filepath = @image.file.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @image.file.url.gsub(/.*\//,''), :length => stat.size)
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :file)
    end
end
