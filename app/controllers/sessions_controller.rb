class SessionsController < ApplicationController

  before_action :forbid_login_user, {only: [:new, :create]}

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end

  end

  def destroy
    logout
    redirect_to root_path, info: 'ログアウトしました'
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

end
