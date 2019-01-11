class TopicsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:show, :edit, :update, :destroy]}

  def index
    @topics = Topic.all.includes(:favorite_users).page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @topic = Topic.find_by(id: params[:id])
  end

  def edit
    @topic = Topic.find_by(id: params[:id])
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    if @topic.update(topic_params)
      redirect_to topics_path, success: '編集に成功しました'
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    @topic.destroy
    redirect_to topics_path, info: '投稿を削除しました'
  end

  def ensure_correct_user
    @topic = Topic.find_by(id: params[:id])
    if current_user.id != @topic.user_id && current_user.admin_id == nil
      redirect_to topics_path, info: '権限がありません'
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end

end
