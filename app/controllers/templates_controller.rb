# noinspection ALL
class TemplatesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.with_associations.sorted_by_recently.page(params[:page])
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    # @comments = @template.comments.order('created_at').includes(:user)
    @user              = @template.user
    @recently_articles = @user.articles.includes(:tags).recently_edit
  end

  # GET /template/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = current_user.templates.create(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to template_path(@template), flash: { success: '記事を作成しました' } }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, flash: { success: '記事を更新しました' } }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to template_url, flash: { success: '記事を削除しました' } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_template
    @template = Template.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def template_params
    params.require(:template).permit(:template_name, :title, :text, :status, :tag_list, :user_id, :lock, :type)
  end

end
