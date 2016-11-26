
GameListActions = Reflux.createActions
  setFilter: {}
  apiGetGames: { asyncResult: true }
  viewGame: { }
  apiJoinGame: { asyncResult: true }

GameListActions.apiGetGames.listenAndPromise (args) ->
  App.Helpers.Api.GET
    url: "/api/games?filter=#{args.filter}"

GameListActions.apiJoinGame.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: "/api/games/#{args.gameId}/join"

module.exports = GameListActions