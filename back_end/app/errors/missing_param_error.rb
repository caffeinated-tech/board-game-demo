class MissingParamError < BaseError
  
  def initialize(param)
    super "Parameter #{param} is missing"
    @status ||= 400
  end

end