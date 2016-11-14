class WrongPasswordError < BaseError
  
  def initialize()
    super "The password is incorrect"
    @status ||= 400
  end

end