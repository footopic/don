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
        format.js { render 'stars/stars' }
      else
        format.json { render json: @star.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1
  # DELETE /stars/1.json
  def destroy
    article = @star.article
    @star.destroy
    @stars = article.stars.includes(:user)
    respond_to do |format|
      format.js { render 'stars/stars' }
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
