module ApplicationHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user
    if !logged_in?
      redirect_to login_path, info: 'ログインが必要です'
    end
  end

  def forbid_login_user
    if logged_in?
      redirect_to root_path, info: 'すでにログインしています'
    end
  end

end
