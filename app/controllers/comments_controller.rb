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

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
　　@comment = Comment.find_by(id: params[:id])
　　@comment.update(comment_params)
    if @comment.save
      redirect_to topics_path, success: 'コメントを編集しました'
    else
      flash.now[:danger] = "コメントの編集に失敗しました"
      render :edit
    end
  end

  def destroy
      @comment = Comment.find_by(id: params[:id])
      @comment.destroy
      redirect_to topics_path, info: "コメントを削除しました"
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :topic_id)
  end
end
