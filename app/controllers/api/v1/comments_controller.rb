class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Article.find(params[:article_id]).comments
    render json: @comments
  end
end
