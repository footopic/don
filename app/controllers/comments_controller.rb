class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # POST /comments
  def create

    @comment = Comment.new(comment_params)
    @article = @comment.article

    if @comment.save
      redirect_to article_path(@article), notice: 'コメントを投稿しました'
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'コメントを更新しました'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to article_path(@comment.article), notice: 'コメントを削除しました'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text, :user_id, :article_id)
  end
end
