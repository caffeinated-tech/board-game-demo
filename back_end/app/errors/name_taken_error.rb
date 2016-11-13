class NameTakenError < ::BaseError
    def initialize()
    super "This user name is already taken"
  end
end