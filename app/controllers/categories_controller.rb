class CategoriesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @search = params[:search]

    @categories = Category.all
    @categories = @categories.search(@search) if @search.present?
    @categories = @categories.page(params[:page])
                             .order(updated_at: :desc).per(10)

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@categories), file_name: 'articles.csv' }
    end

    def new
      @category = Category.new
    end

    def show
      @category = Category.find(params[:id])
    end

    def create
      @category = Category.create(product_params)

      flash[:error] = @category.errors.full_messages if @category.invalid?

      redirect_to action: :index
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      @category.update(product_params)
      redirect_to action: :index
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy
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

    def product_params
      params.require(:category).permit(:name, :description, :stock)
    end
  end
end
