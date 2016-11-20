require 'bcrypt'

class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :private_game, type: Boolean

  field  :white_user_id, type: BSON::ObjectId
  field  :black_user_id, type: BSON::ObjectId


  def as_json(options = {})
    {
      id: id.to_s,
      private_game: private_game,
      white_user_id: white_user_id.to_s,
      black_user_id: black_user_id.to_s
    }
  end
end