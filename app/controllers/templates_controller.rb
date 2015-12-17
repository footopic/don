# noinspection ALL
class TemplatesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  before_action :published?, only: [:show]
  before_action :check_template_owner, only: [:destroy]
  before_action :locked?, only: [:edit, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    # @articles = Template.sorted_by_recently.page(params[:page])
    @articles = Template.with_associations.sorted_by_recently.page(params[:page])
    render 'articles/index'
  end

  # GET /templates/1
  # GET /templates/1.json
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
    render 'articles/show'
  end

  # GET /template/new
  def new
    @article = Template.new
    render 'articles/new'
  end

  # GET /templates/1/edit
  def edit
    render 'articles/edit'
  end

  # POST /templates
  # POST /templates.json
  def create
    @article = current_user.articles.create(template_params)

    respond_to do |format|
      if @article.save
        History.create(user: current_user, article: @article)
        SlackHook.new.post(current_user, t('.slack_message', {
            user:  @article.user.screen_name,
            title: @article.title,
            url:   full_path(article_path(@article))
        }), @article.text)
        format.html { redirect_to template_path(@article), flash: { success: '記事を作成しました' } }
        format.json { render 'articles/show', status: :created, location: @article }
      else
        format.html { render 'articles/edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @article.update(template_params)
        History.create(user: current_user, article: @article)

        SlackHook.new.post(current_user, t('.slack_message', {
            user:  @article.user.screen_name,
            title: @article.title,
            url:   full_path(article_path(@article))
        }), @article.text)

        format.html { redirect_to @article, flash: { success: '記事を更新しました' } }
        format.json { render 'articles/show', status: :ok, location: @article }
      else
        format.html { render 'articles/edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to template_url, flash: { success: '記事を削除しました' } }
      format.json { head :no_content }
    end
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
  def set_template
    @article = Template.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def template_params
    params.require(:template).permit(:template_name, :title, :text, :status, :tag_list, :user_id, :lock, :type)
  end

  def check_template_owner
    unless current_user.owner?(@article)
      # TODO: セキュリティ上メッセージは消す
      redirect_to @article, notice: '記事の作者ではありません'
    end
  end

end
