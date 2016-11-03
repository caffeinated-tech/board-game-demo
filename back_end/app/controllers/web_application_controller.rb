class WebApplicationController < ApplicationController

	def index
		puts "rendering index"
		render 'web_application/index'
	end


end
