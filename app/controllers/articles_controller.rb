# noinspection ALL
class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :published?, only: [:show]
  before_action :check_article_owner, only: [:destroy]
  before_action :locked?, only: [:edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    if params[:tag]
      @articles = @q.result.with_associations.tagged_with(params[:tag]).sorted_by_recently.page(params[:page])
    else
      @articles = @q.result.with_associations.sorted_by_recently.page(params[:page])
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
    @recently_histories         = @article.histories.includes(:user).order('created_at desc').take(5)
    if @user.screen_name == 'esa'
      flash.now[:notice] = t '.esa_message'
    end
  end

  # GET /articles/history/1
  def history
    @article   = Article.find(params[:article_id])
    @histories = @article.histories.includes(:user).order('created_at desc')
    @css = Diffy::CSS
  end

  # GET /articles/new
  def new
    @article   = Article.new
    @templates = Template.includes(:tags)
    compare    = Compare.new(current_user)
    @templates.map { |template| template.set_compare(compare) }
    @tag_list = ActsAsTaggableOn::Tag.all.map &:name
  end

  # GET /articles/1/edit
  def edit
    @tag_list = ActsAsTaggableOn::Tag.all.map &:name
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.create(article_params)

    respond_to do |format|
      if @article.save
        History.create(user: current_user, article: @article, diff: diff = Diffy::Diff.new('', @article.text))

        if @article.notice
          SlackHook.new.post(current_user, t('.slack_message', {
              user:  @article.user.screen_name,
              title: @article.title,
              url:   full_path(article_path(@article))
          }), @article.text)
        end

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
      # diff = Diffy::Diff.new(article_params[:text], @article.text, :context => 1)
      diff = Diffy::Diff.new(@article.text, article_params[:text], :context => 2)
      if article_params[:title] != @article.title
        title_diff =  t('diff.title', { pre_title: @article.title, title: article_params[:title] })
      end
      if @article.update(article_params)
        slack_text = ''
        if diff.to_s != ''
          slack_text = diff.to_s
          History.create(user: current_user, article: @article, diff: diff.to_s(:html))
        end
        if title_diff
          slack_text = title_diff
          History.create(user: current_user, article: @article, diff: title_diff)
        end
        if @article.notice and slack_text != ''
          SlackHook.new.post(current_user, t('.slack_message', {
              user:  @article.user.screen_name,
              title: @article.title,
              url:   full_path(article_path(@article))
          }), slack_text)
          p slack_text
        end

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

  def lock
    @article = Article.find(params[:article_id])
    return if @article.lock?
    @article.lock = true
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, flash: { success: '記事を保護しました' } }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def unlock
    @article = Article.find(params[:article_id])
    return if @article.unlock?
    @article.lock = false
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, flash: { success: '保護を解除しました' } }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def published?
    unless @article.status.publish?
      authenticate_user!
    end
  end

  def locked?
    if !@article.written_by?(current_user) && @article.lock
      redirect_to @article
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :text, :status, :tag_list, :user_id, :lock, :notice)
  end

  def check_article_owner
    unless current_user.owner?(@article)
      # TODO: セキュリティ上メッセージは消す
      redirect_to @article, notice: '記事の作者ではありません'
    end
  end

end
