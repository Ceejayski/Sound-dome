class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new create]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    @best_article = Article.most_vote
  end

  # GET /articles/1
  # GET /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.build(article_params)

    if @article.save && @article.valid?
      params[:category].each do |cat|
        Categorying.create(article_id: @article.id, category_id: cat)
      end
      redirect_to new_article_path, notice: 'article Created Successfully'
    else
      render 'new'
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' Updated!"
    redirect_to article_path(@article)
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :body, :user_id, :pic)
  end
end
