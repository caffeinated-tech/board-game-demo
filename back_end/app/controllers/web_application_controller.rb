class WebApplicationController < ApplicationController

  protect_from_forgery
  
  after_filter :set_csrf_cookie
  
  def index
    puts "rendering index"
    render 'web_application/index'
  end

  private

  def set_csrf_cookie
    return unless protect_against_forgery?
    cookies['XSRF-TOKEN'] = form_authenticity_token 
  end
end
