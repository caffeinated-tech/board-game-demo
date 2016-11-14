module Api
  class UsersController < WebApplicationController
    before_action :check_unique_name, only: [:create]
    before_action :check_params_exist
    skip_before_action :auth_check, only: [:login, :create]

  	def create
      user = User.create user_params
      login_user(user)
      render json: user  
  	end

    def login
      puts request.headers['X-CSRF-Token']
      user = User.where(name: user_params[:name]).first
      raise WrongNameError.new if user.nil?
      raise WrongPasswordError.new unless user.password == user_params[:password]
      # passed all checks - login and return the user data
      login_user(user)
      render json: user 
    end

    private

    def user_params
      params.require(:user).permit(:name, :password)
    end

    def check_params_exist
      raise MissingParamError.new('name') if user_params[:name].nil?
      raise MissingParamError.new('password') if user_params[:password].nil?
    end

    def check_unique_name
      raise NameTakenError.new if User.where(name: user_params[:name]).exists?
    end

    def login_user(user)
      puts "login user"
      session[:user_id] = user.id.to_s
      ap session
    end

  end
end