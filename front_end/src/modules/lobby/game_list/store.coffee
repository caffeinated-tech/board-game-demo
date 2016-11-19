
GameListStore = App.Helpers.CreateStore
  init: ->
    @inputs = {}
    @display = {}
    @inputs = {}

  registerListeners: ->
    @listenToMany App.Modules.Lobby.GameList.actions

  onSetFilter: (filter) ->
    @display.filter = filter
    @update()


module.exports = GameListStore