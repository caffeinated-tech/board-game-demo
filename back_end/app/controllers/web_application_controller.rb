class WebApplicationController < ApplicationController

  
  before_action :auth_check, except: [:index]
  before_action :initialize_gon
  protect_from_forgery
  after_action :set_csrf_cookie

  rescue_from ::BaseError do |error|
    render status:error.status, json: error
  end
  
  def index
    render 'web_application/index'
  end

  def logout
    reset_session
    @current_user = nil
    redirect_to  action: :index
  end

  private

  def auth_check
    return if current_user.present? 
    redirect_to action: :index, controller: '/web_application' 
  end

  def initialize_gon
    gon.user = current_user
  end

  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find(session[:user_id]) 
  end

  def set_csrf_cookie
    return unless protect_against_forgery?
    cookies['CSRF-TOKEN'] = form_authenticity_token 
  end
end
