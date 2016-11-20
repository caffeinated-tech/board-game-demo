
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = {}
    @board = {}

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()

  props: ->
    game: @game
    display: @display


  _initializeGame: ->
    @board = {} 
      
module.exports = GameStore