require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name, type: String
  field :password_hash, type: String

  

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def ongoing_game
    Game.ongoing_for_user(self.id).first
  end

  def as_json(options = {})
    {
      id: id.to_s,
      name: name,
      game: ongoing_game.as_json 
    }
  end
end