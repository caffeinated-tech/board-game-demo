module Api
  class UsersController < WebApplicationController

  	def create
  		puts "create a user"
      puts user_params.inspect
      user = User.create user_params
  	end

    private

    def user_params
      params.require(:user).permit(:name, :password)
    end

    def unique_name
      raise NameTakenError.new if User.find_by name: user_params[:name]
    end

  end
end