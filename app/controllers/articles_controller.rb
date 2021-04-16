class ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @search = params[:search]

    @articles = Article.all
    @articles = @articles.search(@search) if @search.present?
    @articles = @articles.page(params[:page])
                         .order(updated_at: :desc).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@articles), file_name: 'articles.csv' }
    end
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

  def csv_upload
    data = params[:csv_file].read.split("\n")
    data.each do |line|
      attr = line.split(',').map(&:strip)
      Article.create title: attr[0], body: attr[1]
    end
    redirect_to action: :index
  end

  private

  def generate_csv(articles)
    articles.map { |a| [a.title, a.body, a.created_at.to_date].join(',') }.join("\n")
  end

  def article_params
    params.require(:article).permit(:title, :body, :cover_image, images: [], category_ids: [])
  end
end
