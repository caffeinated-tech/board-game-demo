
LobbyActions = Reflux.createActions
  apiNewGame: { asyncResult: true }

LobbyActions.apiNewGame.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: '/api/games'
    data: 
      game: args


module.exports = LobbyActions