class CommentsController < ApplicationController

  before_action :authenticate_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to topics_path, success: 'コメントを投稿しました'
    else
      flash.now[:danger] = "コメントの投稿に失敗しました"
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :topic_id)
  end
end
