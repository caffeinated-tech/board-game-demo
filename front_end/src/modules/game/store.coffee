
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

  _isValidMove: ->
    if /pawn/.test @firstSquare.piece
      @_isValidMoveForPawn()
    else if /rook/.test @firstSquare.piece
      @_isValidMoveForRook()
    else if /knight/.test @firstSquare.piece
      @_isValidMoveForKnight()
    else if /bishop/.test @firstSquare.piece
      @_isValidMoveForBishop()
    else if /king/.test @firstSquare.piece
      @_isValidMoveForKing()
    else if /queen/.test @firstSquare.piece
      @_isValidMoveForQueen()
    else
      false

  _isValidMoveForPawn: ->
    if @secondSquare.piece is null
      # we are moving into an empty square, this is only allowed if the pawn is
      #   moving straight ahead
      return false if @firstSquare.column isnt @secondSquare.column
      # even if we are in the same coumn, check that we are moving in
      #   the correct direction for our colour
      if @player.colour is 'white'
        # check that I'm moving forward
        return false if @firstSquare.row < @secondSquare.row
        # I'm allowed to move forward by 1
        return true if @firstSquare.row - 1 is @secondSquare.row
        # I'm allowed to move forward by 2 if the pawn is in it's starting 
        #   position
        return true if @firstSquare.row is 6 and @secondSquare.row is 4
        # otherwise we can't move
        false
      else
        # check that I'm moving forward
        return false if @firstSquare.row > @secondSquare.row
        # I'm allowed to move forward by 1
        return true if @firstSquare.row + 1 is @secondSquare.row
        # I'm allowed to move forward by 2 if the pawn is in it's starting 
        #   position
        return true if @firstSquare.row is 1 and  @secondSquare.row 3
        # otherwise we can't move
        false
    else
      if @player.colour is 'white'
        # we need to be moving forward
        return false unless @firstSquare.row - 1 is @secondSquare.row
        # we need to be moving left or right by one column
        return false unless @firstSquare.column - 1 is @secondSquare.column or
          @firstSquare.column + 1 is @secondSquare.column
        true
      else
        # we need to be moving forward
        return false unless @firstSquare.row - 1 is @secondSquare.row
        # we need to be moving left or right by one column
        return false unless @firstSquare.column - 1 is @secondSquare.row or
          @firstSquare.column + 1 is @secondSquare.row
        true

  _isValidMoveForRook: ->
    console.log @firstSquare.column
    console.log @firstSquare.row
    console.log @secondSquare.column
    console.log @secondSquare.row

  _isValidMoveForKnight: ->
    console.log @firstSquare.column
    console.log @firstSquare.row
    console.log @secondSquare.column
    console.log @secondSquare.row

  _isValidMoveForBishop: ->
    console.log @firstSquare.column
    console.log @firstSquare.row
    console.log @secondSquare.column
    console.log @secondSquare.row

  _isValidMoveForKing: ->
    console.log @firstSquare.column
    console.log @firstSquare.row
    console.log @secondSquare.column
    console.log @secondSquare.row

  _isValidMoveForQueen: ->
    console.log @firstSquare.column
    console.log @firstSquare.row
    console.log @secondSquare.column
    console.log @secondSquare.row


module.exports = GameStore