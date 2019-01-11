class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :show, :edit, :update, :favorites]}
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:show, :edit, :update, :destroy]}

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, success: '登録に成功しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to user_path, success: '編集に成功しました'
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_path, info: 'ユーザー情報を削除しました'
  end

  def favorites
    @user = User.find_by(id: params[:id])
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if current_user.id != @user.id && current_user.admin_id == nil
      redirect_to users_path, info: "権限がありません"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
