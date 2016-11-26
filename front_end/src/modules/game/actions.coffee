GameActions = Reflux.createActions
  setGame: {}
  selectSquare: {}
  setPlayer: {}
  setEnemy: {}
  apiMove: { asyncResult: true }
  apiGetUpdates: { asyncResult: true }
  apiForfeit: { asyncResult: true }

GameActions.apiMove.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: "/api/games/#{args.gameId}/move"
    data:
      from: args.from
      to: args.to

GameActions.apiGetUpdates.listenAndPromise (args) ->
  App.Helpers.Api.GET
    url: "/api/games/#{args.gameId}/move/#{args.nextMove}"
  
GameActions.apiForfeit.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: "/api/games/#{args.gameId}/forfeit"
  
module.exports = GameActions