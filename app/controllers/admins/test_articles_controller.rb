module Admins
  class TestArticlesController < ApplicationController
    def index
      @search = params[:search]
      @articles = Article.all
      if @search.present?
        @articles = @articles.where('title LIKE ? or body LIKE ?', "%#{@search}", "%#{@search}").page(@search).per(5)
      end
      @articles = @articles.page(params[:page]).per(10)
    end
  end
end
