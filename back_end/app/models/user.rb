require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name, type: String
  field :password_hash, type: String
  
  field :ongoing_game_id, type: BSON::ObjectId  

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def ongoing_game
    return unless self.ongoing_game_id.present?
    Game.find ongoing_game_id
  end

  def as_json(options = {})
    {
      id: id.to_s,
      name: name,
      game: ongoing_game.as_json 
    }
  end
end