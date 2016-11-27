module Api
  class GamesController < WebApplicationController

    def index
      open_games = if filter_params[:filter] == 'open'
        Game.where(
          local: false,
          winner: nil,
          private_game: false,
          '$or' => [
            { white_user_id: nil },
            { black_user_id: nil }
            ]
          ).order(created_at: -1).entries
      else
        Game.where(
          winner: { '$ne' => nil },
          ).order(created_at: -1).entries
      end
      render json: open_games
    end

  	def create
      # the user already has a game, redirect them to it
      if current_user.ongoing_game_id.present?
        return render json: current_user.ongoing_game
      end

      @game = Game.new(
        private_game: !!game_params[:private_game],
        local: !!game_params[:local],
        )
      # set the user who created the game as either the black or white player
      if game_params[:white]
        game.white_user_id = current_user.id 
        game.white_user_name = current_user.name 
      else
        game.black_user_id = current_user.id 
        game.black_user_name = current_user.name
      end
      game.save

      current_user.ongoing_game_id = game.id
      current_user.save

      render json: game
  	end

    def join
      game.join current_user
      game.save
      current_user.save

      render json: game
    end

    def move
      game.record_move(from_params, to_params)
      game.save 

      head :ok
    end

    def check_for_move
      number = check_for_move_params[:number].to_i
      move = game.moves[number]
      render json: move
    end

    def forfeit
      game.forfeit current_user
      game.save 

      render json: game
    end

    private

    def game
      @game ||= Game.find game_id_params[:game_id]
    end

    def filter_params
      params.permit(:filter)
    end

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

    def check_for_move_params
      params.permit(:number)
    end
  end
end

