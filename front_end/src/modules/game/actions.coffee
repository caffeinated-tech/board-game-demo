GameActions = Reflux.createActions
  setGame: {}
  selectSquare: {}
  setPlayer: {}
  setEnemy: {}
  apiMove: { asyncResult: true }

GameActions.apiMove.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: "/api/games/#{args.gameId}/move"
    data:
      from: args.from
      to: args.to

  
module.exports = GameActions