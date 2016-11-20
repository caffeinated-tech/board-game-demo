module Api
  class GamesController < WebApplicationController

  	def create    
      game = Game.new(
        private_game: game_params[:private_game]
        )
      # set the user who created the game as either the black or white player
      if game_params[:white]
        game.white_user_id = current_user.id 
      else
        game.black_user_id = current_user.id 
      end

      render json: game
  	end

    private

    def game_params
      params.require(:game).permit(:white, :private_game)
    end
  end
end