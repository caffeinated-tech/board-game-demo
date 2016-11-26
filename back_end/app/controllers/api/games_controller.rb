module Api
  class GamesController < WebApplicationController

    def index
      open_games = Game.where(
        local: false,
        finished: false,
        private_game: false,
        '$or' => [
          { white_user_id: nil },
          { black_user_id: nil }
          ]
        ).order(created_at: -1).entries
      render json: open_games
    end

  	def create    
      game = Game.new(
        private_game: !!game_params[:private_game],
        local: !!game_params[:local],
        finished: false
        )
      # set the user who created the game as either the black or white player
      if game_params[:white]
        game.white_user_id = current_user.id 
        game.white_user_name = current_user.name 
      else
        game.black_user_id = current_user.id 
        game.black_user_id = current_user.name
      end
      game.save

      render json: game
  	end

    def join
      game = Game.find game_id_params[:game_id]
      game.join current_user
      game.save

      render json: game
    end

    def move
      game = Game.find game_id_params[:game_id]
      game.record_move(from_params, to_params)
      game.save 

      head :ok
    end

    private

    def game_params
      params.require(:game).permit(:white, :private_game, :local)
    end

    def game_id_params
      params.permit(:game_id)
    end

    def from_params
      params.require(:from).permit(:column, :row, :piece)
    end

    def to_params
      params.require(:to).permit(:column, :row, :piece)
    end
  end
end

