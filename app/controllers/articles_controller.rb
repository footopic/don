# noinspection ALL
class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :check_article_owner, only: [:destroy]

  # GET /articles
  # GET /articles.json
  def index
    if params[:tag]
      @articles = @q.result.includes(:tags, :user).tagged_with(params[:tag]).order('updated_at DESC').page(params[:page])
    else
      @articles = @q.result.includes(:tags, :user).order('updated_at DESC').page(params[:page])
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @comments = @article.comments.order('created_at').includes(:user)

    user_ids           = History.where(article: @article).pluck(:user_id)
    @user              = @article.user
    @editors           = User.find(user_ids).uniq
    @stars             = @article.stars.includes(:user)
    @recently_articles = @user.articles.includes(:tags).recently_edit
    @histories         = @article.histories.includes(:user).order('created_at desc')
    if @user.screen_name == 'esa'
      flash.now[:notice] = t '.esa_message'
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
    render :edit
  end

  # GET /articles/1/edit
  def edit
    History.create(user: current_user, article: @article)
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.create(article_params)
    History.create(user: current_user, article: @article)

    respond_to do |format|
      if @article.save
        SlackHook.new.post(current_user, t('.slack_message', {
            user:  @article.user.screen_name,
            title: @article.title,
            url:   full_path(article_path(@article))
        }), @article.text)
        format.html { redirect_to @article, flash: { success: '記事を作成しました' } }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        SlackHook.new.post(current_user, t('.slack_message', {
            user:  @article.user.screen_name,
            title: @article.title,
            url:   full_path(article_path(@article))
        }), @article.text)

        format.html { redirect_to @article, flash: { success: '記事を更新しました' } }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, flash: { success: '記事を削除しました' } }
      format.json { head :no_content }
    end
  end

  def search
    index
    render :index
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :text, :tag_list, :user_id)
  end

  def check_article_owner
    unless current_user.owner?(@article)
      # TODO: セキュリティ上メッセージは消す
      redirect_to @article, notice: '記事の作者ではありません'
    end
  end

end
