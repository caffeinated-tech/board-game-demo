
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = null
    @_initializeGame()
    @firstSquare = null 
    @secondSquare = null 

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()
    @_setPlayerColour() if @player?

  onSelectSquare: (column, row) ->
    if @firstSquare?
      @_setSecondSquare column, row
    else
      @_setFirstSquare column, row
    
  onSetPlayer: (user) -> 
    @player = user 
    if not @game? and user.game?
      @game = user.game
      @_setPlayerColour()
    @update()


  props: ->
    game: @game
    display: @display
    board: @board

  _initializeGame: ->
    @board = SetupStartingPieces() 
      
  _setFirstSquare: (column, row) ->
    piece = @board[row][column]
    # can only select a piece of the same colour as the user
    return unless piece? and @_pieceIsUserColour(piece)
    @firstSquare =
      column: column
      row: row
      piece: piece

  _setSecondSquare: (column, row) ->
    piece = @board[row][column]
    # can't move own piece onto own piece
    @secondSquare =
      column: column
      row: row
      piece: piece

    if (piece? and @_pieceIsUserColour(piece)) or not @_isValidMove()
      # reset move and return
      @firstSquare = @secondSquare = null
      return
    # TODO: check if this move is valid
    # remove piece from first square
    @board[@firstSquare.row][@firstSquare.column] = null
    # place piece from first to second square
    @board[row][column] = @firstSquare.piece
    # reset selected squares after
    @firstSquare = @secondSquare = null
    @update()

  _setPlayerColour: ->
    if @game.white_user_id is @player.id
      @player.colour = 'white'
    else
      @player.colour = 'black'

  # compare colour of user to the piece to see if they are allowed to move it
  _pieceIsUserColour: (piece) ->
    new RegExp(@player.colour).test(piece)

module.exports = GameStore