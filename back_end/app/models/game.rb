require 'bcrypt'

class Game
  include Mongoid::Document
  include Mongoid::Timestamps

  field :private_game, type: Boolean
  field :local, type: Boolean
  field :winner, type: BSON::ObjectId
  field :forfeited, type: Boolean, default: false

  field :white_user_id, type: BSON::ObjectId
  field :black_user_id, type: BSON::ObjectId

  field :white_user_name, type: String
  field :black_user_name, type: String

  field :moves, type: Array, default: []


  scope :ongoing, -> { where(finished: false) }

  scope :ongoing_for_user, ->(user_id) {
    ongoing.where({ '$or' => [
      { white_user_id: user_id },
      { black_user_id: user_id }
    ]})
  }

  def join(user)
    if white_user_id.present?
      return if white_user_id == user.id
      self.black_user_id = user.id
      self.black_user_name = user.name
    else
      return if black_user_id == user.id
      self.white_user_id = user.id
      self.white_user_name = user.name
    end
  end

  def record_move(from, to)
    self.moves << {
      from: from,
      to: to
    }
  end

  def forfeit(user)
    self.forfeited = true
    if white_user_id == user.id
      self.winner = black_user_id
    else
      self.winner = white_user_id
    end
  end

  def as_json(options = {})
    data = {
      id: id.to_s,
      local: local,
      private_game: private_game,
      white_user_id: white_user_id&.to_s,
      black_user_id: black_user_id&.to_s,
      white_user_name: white_user_name&.to_s,
      black_user_name: black_user_name&.to_s,
      finished: winner.present?,
      winner: winner,
      forfeited: forfeited,
      moves: moves
    }
  end
end