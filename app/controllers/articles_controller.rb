class ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search = params[:search]
    @articles = Article.all
    if @search.present?
      @articles = @articles.where('title LIKE ? or body LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(10)
    end
    @articles = @articles.page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.create(article_params)

    flash[:error] = @article.errors.full_messages if @article.invalid?

    redirect_to action: :index
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to action: :index
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to action: :index
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
