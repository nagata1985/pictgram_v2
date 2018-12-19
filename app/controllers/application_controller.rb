class ApplicationController < ActionController::Base

  before_action :current_user

  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  include ApplicationHelper

end
