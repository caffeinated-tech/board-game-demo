
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = {}
    @_initializeGame()
    @firstSquare = null 
    @secondSquare = null 

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()

  onSelectSquare: (column, row) ->
    if @firstSquare?
      @_setSecondSquare column, row
    else
      @_setFirstSquare column, row
    
  props: ->
    game: @game
    display: @display
    board: @board

  _initializeGame: ->
    @board = SetupStartingPieces() 
      
  _setFirstSquare: (column, row) ->
    piece = @board[row][column]
    @firstSquare =
      column: column
      row: row
      piece: piece

  _setSecondSquare: (column, row) ->
    piece = @board[row][column]
    @secondSquare =
      column: column
      row: row
      piece: piece
    # TODO: check if this move is valid
    # remove piece from first square
    @board[@firstSquare.row][@firstSquare.column] = null
    # place piece from first to second square
    @board[row][column] = @firstSquare.piece
    # reset selected squares after
    @firstSquare = @secondSquare = null
    @update()



module.exports = GameStore