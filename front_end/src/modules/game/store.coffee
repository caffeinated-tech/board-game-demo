
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = {}
    @_initializeGame()

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()

  props: ->
    game: @game
    display: @display
    pieces: @_piecesFromGameState()

  _initializeGame: ->
    @gameState = SetupStartingPieces() 
      

  _piecesFromGameState: ->
    # initialize an empty grid
    piecesByRow = for row in [0..7]
      for column in [0..7]
        null
    
    for color, pieces of @gameState
      for piece, coordinates of pieces
        [y,x] = coordinates
        piecesByRow[y][x] = "#{color}_#{piece}"

    piecesByRow

module.exports = GameStore