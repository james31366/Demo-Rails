module Admins
  class CommentsController < ApplicationController
    def create
      @article = Article.find params[:article_id]
      @article.comments.create(comment_params)
      redirect_to admins_article_path(@article)
    end

    private

    def comment_params
      params.require(:comment).permit(:author, :text)
    end
  end
end
