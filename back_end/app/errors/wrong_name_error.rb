class WrongNameError < BaseError
  
  def initialize()
    super "No user exists with this name"
    @status ||= 400
  end

end