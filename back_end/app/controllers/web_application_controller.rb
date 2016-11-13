class WebApplicationController < ApplicationController

  protect_from_forgery
  
  before_filter :auth_check, except: [:index]
  before_filter :initialize_gon
  after_filter :set_csrf_cookie

  rescue_from ::BaseError do |error|
    render status:error.status, json: error
  end
  
  def index
    puts "rendering index"
    render 'web_application/index'
  end

  private

  def auth_check
    puts "\n log data"
    ap session
    return redirect_to action: :index if current_user.nil?
    puts "authenticated, current user is"
    ap current_user 
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
    cookies['XSRF-TOKEN'] = form_authenticity_token 
  end
end
