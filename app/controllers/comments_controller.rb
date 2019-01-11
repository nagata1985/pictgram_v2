class CommentsController < ApplicationController

  before_action :authenticate_user
  #before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:show, :edit, :update, :destroy]}

  def new
    @comment = Comment.new

  end

  def create
    @comment = current_user.comments.new(comment_params)
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
    if @comment.update(comment_params)
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

  def ensure_correct_user
    @comment = Comment.find_by(id: params[:id])
    if current_user.id != @comment.user_id && current_user.admin_id == nil
      redirect_to topics_path, info: '権限がありません'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :topic_id)
  end
end
