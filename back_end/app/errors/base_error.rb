class BaseError < StandardError
  attr_reader :status

  def initialize(message)
    super message
    @status ||= 400
  end

  def as_json(options={})
    {
      name: self.class.to_s,
      message: self.message
    }
  end

end