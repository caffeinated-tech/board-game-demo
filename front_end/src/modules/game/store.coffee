
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = {}

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()

  props: ->
    game: @game
    display: @display

module.exports = GameStore