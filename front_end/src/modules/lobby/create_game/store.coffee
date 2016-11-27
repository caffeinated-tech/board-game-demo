
CreateGameStore = App.Helpers.CreateStore
  init: ->
    @inputs = {}
    @display = {}

  registerListeners: ->
    @listenToMany App.Modules.Lobby.CreateGame.actions

  onApiNewGameCompleted: (res) ->
    App.Modules.Game.actions.setGame res
    ReactRouter.browserHistory.push '/game'

module.exports = CreateGameStore