class StarsController < ApplicationController
  before_action :set_star, only: [:destroy]

  # POST /stars
  # POST /stars.json
  def create
    @article = Article.find(star_params[:article_id])
    @star    = Star.new(star_params)
    @stars   = @article.stars.includes(:user)

    respond_to do |format|
      if @star.save
        format.js { render 'stars/create' }
      else
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1
  # DELETE /stars/1.json
  def destroy
    @star.destroy
    respond_to do |format|
      format.html { redirect_to stars_url, notice: 'Star was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_star
    @star = Star.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def star_params
    params.require(:star).permit(:user_id, :article_id)
  end
end
