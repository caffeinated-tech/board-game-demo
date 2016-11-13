module Api
  class UsersController < WebApplicationController
    before_action :check_unique_name, only: [:create]
    before_action :check_not_logged_in, only: [:create]

  	def create
  		puts "create a user"
      ap user_params
      user = User.create user_params
      login_user(user)
      render json: user  
  	end

    private

    def user_params
      params.require(:user).permit(:name, :password)
    end

    def check_unique_name
      raise NameTakenError.new if User.find_by name: user_params[:name]
    end

    def check_not_logged_in
      raise AlreadyLoggedInErrorn.new if user.present?
    end

    def login_user(user)
      session[:user_id] = user.id.to_s
    end

  end
end