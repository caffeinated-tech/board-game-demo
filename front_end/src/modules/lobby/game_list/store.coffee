
GameListStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @games = []
    
  registerListeners: ->
    @listenToMany App.Modules.Lobby.GameList.actions

  onSetFilter: (filter) ->
    @display.filter = filter
    App.Modules.Lobby.GameList.actions.apiGetGames 
      filter: filter
    @update()

  # the user has joined the game - now redirect the user to the game view
  onApiJoinGameCompleted: (game) ->
    App.Modules.Game.actions.setGame game
    ReactRouter.browserHistory.push "/game/#{game.id}"

  onViewGame: (game) ->
    App.Modules.Game.actions.setGame game
    ReactRouter.browserHistory.push "/game/#{game.id}"

  onApiGetGamesCompleted: (games) ->
    console.log 'games', games
    @games = games
    @update()

  props: ->
    display: @display
    games: @games

module.exports = GameListStore