class FavoritesController < ApplicationController

  before_action :authenticate_user  

  def index
  end

  def create
    favorite = Favorite.new(user_id: current_user.id, topic_id: params[:topic_id])
    if favorite.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りに登録に失敗しました'
    end
  end

  def delete
    favorite = Favorite.find_by(user_id: current_user.id, topic_id: params[:topic_id])
    favorite.destroy
    flash.now[:danger] = "お気に入りを解除しました"
    redirect_to topics_path, info: 'お気に入りの登録を解除しました'
  end

end
