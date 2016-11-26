
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = null
    @validMoves = []
    @firstSquare = null 
    @secondSquare = null 
    @turn = 'white'

  registerListeners: ->
    @listenToMany App.Modules.Game.actions

  onSetGame: (res) ->
    @game = res
    @update()
    @_initializeGame()
    @_setPlayerColour() if @player?


  onSelectSquare: (column, row) ->
    return unless @game.local? or @turn is @player.colour
    if @firstSquare?
      @_setSecondSquare column, row
    else
      @_setFirstSquare column, row
    
  onSetPlayer: (user) -> 
    @player = user 
    if not @game? and user.game?
      @game = user.game
      @_setPlayerColour()
      @_initializeGame()
    @update()

  props: ->
    game: @game
    display: @display
    board: @board
    validMoves: @validMoves
    selectedSquare: "#{@firstSquare.row}#{@firstSquare.column}" if @firstSquare?

  _initializeGame: ->
    @board = SetupStartingPieces() 
    for move in @game.moves
      @firstSquare = move.from
      @secondSquare = move.to
      @_makeMove()
      
  _setFirstSquare: (column, row) ->
    piece = @board[row][column]
    # can only select a piece of the same colour as the user
    unless piece? and @_pieceIsUserColour(piece)
      @_resetSelectedSquares()
      @update()
      return

    @firstSquare =
      column: column
      row: row
      piece: piece
    @_markValidMoves()
    @update()

  _setSecondSquare: (column, row) ->
    piece = @board[row][column]
    # can't move own piece onto own piece
    @secondSquare =
      column: column
      row: row
      piece: piece

    move = "#{row}#{column}"
    validMove = move in @validMoves
    if (piece? and @_pieceIsUserColour(piece)) or not validMove
      @_resetSelectedSquares()
      @update()
      return
    @_recordMove()
    @_makeMove()

  _recordMove: ->
    # record move on server 
    # TODO: order needs to be guaranteed
    App.Modules.Game.actions.apiMove
      gameId: @game.id
      from: @firstSquare
      to: @secondSquare

  _makeMove: ->
    # remove piece from first square
    @board[@firstSquare.row][@firstSquare.column] = null
    # place piece from first to second square
    @board[@secondSquare.row][@secondSquare.column] = @firstSquare.piece
    # reset selected squares after move
    @_resetSelectedSquares()
    @_nextPlayer()
    @update()

  _nextPlayer: ->
    @turn = if @turn is 'white' then 'black' else 'white' 

  _resetSelectedSquares: ->
    @firstSquare = @secondSquare = null
    @validMoves = []

  _setPlayerColour: ->
    if @game.white_user_id is @player.id
      @player.colour = 'white'
    else
      @player.colour = 'black'

  # compare colour of user to the piece to see if they are allowed to move it
  _pieceIsUserColour: (piece) ->
    new RegExp(@turn).test(piece)

  _markValidMoves: ->
    if /pawn/.test @firstSquare.piece
      @_markValidMovesForPawn()
    else if /rook/.test @firstSquare.piece
      @_markValidMovesForRook()
    else if /knight/.test @firstSquare.piece
      @_markValidMovesForKnight()
    else if /bishop/.test @firstSquare.piece
      @_markValidMovesForBishop()
    else if /king/.test @firstSquare.piece
      @_markValidMovesForKing()
    else if /queen/.test @firstSquare.piece
      @_markValidMovesForQueen()
    else
      false

  _markValidMovesForPawn: ->
    row = @firstSquare.row
    col = @firstSquare.column
    direction = if @turn is 'white' then -1 else 1 

    # can move forward unless there is a piece in that spot
    if @_emptySquare(row + direction, col)
      @validMoves.push "#{row+direction}#{col}"
    # starting row means we can move forward by two
    if row is 6 or row is 1 and @_emptySquare(row+(direction*2), col) 
      @validMoves.push "#{row+(direction*2)}#{col}"
    # now check for pieces in the diagonal locaitons which can be taken
    if @_enemySquare(row + direction, col-1)
      @validMoves.push "#{row+direction}#{col-1}"
    if @_enemySquare(row + direction, col+1)
      @validMoves.push "#{row+direction}#{col+1}"

  _markValidMovesForRook: ->
    row = @firstSquare.row
    col = @firstSquare.column
    # up
    if row isnt 0
      for r in [row-1..0]
        break if @_playerSquare(r,col)
        @validMoves.push "#{r}#{col}"
        break if @_enemySquare(r,col)
    # down
    if row isnt 7
      for r in [row+1..7]
        break if @_playerSquare(r,col)
        @validMoves.push "#{r}#{col}"
        break if @_enemySquare(r,col)
    # left
    if col isnt 0
      for c in [col-1..0]
        break if @_playerSquare(row,c)
        @validMoves.push "#{row}#{c}"
        break if @_enemySquare(row,c)
    # right
    if col isnt 7
      for c in [col+1..7]
        break if @_playerSquare(row,c)
        @validMoves.push "#{row}#{c}"
        break if @_enemySquare(row,c)

  _markValidMovesForKnight: ->
    row = @firstSquare.row
    col = @firstSquare.column
    possibleMoves = []
    possibleMoves.push [row+1, col+2]
    possibleMoves.push [row+1, col-2]
    possibleMoves.push [row-1, col+2]
    possibleMoves.push [row-1, col-2]
    possibleMoves.push [row+2, col+1]
    possibleMoves.push [row+2, col-1]
    possibleMoves.push [row-2, col+1]
    possibleMoves.push [row-2, col-1]
    for move in possibleMoves
      [r,c] = move
      continue unless r in [0..7] and c in [0..7]
      @validMoves.push "#{r}#{c}" unless @_playerSquare(r,c)

  _markValidMovesForBishop: ->
    row = @firstSquare.row
    col = @firstSquare.column
    # NE
    if row isnt 0 and col isnt 0
      c = col
      for r in [row-1..0]
        c -= 1
        break if c < 0
        break if @_playerSquare(r,c)
        @validMoves.push "#{r}#{c}"
        break if @_enemySquare(r,c)
    # SE
    if row isnt 7 and col isnt 0
      c = col
      for r in [row+1..7]
        c -= 1
        break if c < 0
        break if @_playerSquare(r,c)
        @validMoves.push "#{r}#{c}"
        break if @_enemySquare(r,c)
    # SW
    if row isnt 7 and col isnt 7
      r = row
      for c in [col+1..7]
        r += 1
        break if r > 7
        break if @_playerSquare(r,c)
        @validMoves.push "#{r}#{c}"
        break if @_enemySquare(r,c)
    # NW
    if row isnt 0 and col isnt 7
      r = row
      for c in [col+1..7]
        r -= 1
        break if r < 0
        break if @_playerSquare(r,c)
        @validMoves.push "#{r}#{c}"
        break if @_enemySquare(r,c)

  _markValidMovesForKing: ->
    row = @firstSquare.row
    col = @firstSquare.column
    possibleMoves = []
    possibleMoves.push [row,col+1]
    possibleMoves.push [row,col-1]
    possibleMoves.push [row+1,col]
    possibleMoves.push [row-1,col]
    possibleMoves.push [row+1,col+1]
    possibleMoves.push [row-1,col+1]
    possibleMoves.push [row+1,col-1]
    possibleMoves.push [row-1,col-1]
    for move in possibleMoves
      [r,c] = move
      continue unless r in [0..7] and c in [0..7]
      @validMoves.push "#{r}#{c}" unless @_playerSquare(r,c)

  _markValidMovesForQueen: ->
    @_markValidMovesForRook()
    @_markValidMovesForBishop()

  _emptySquare: (row, column) ->
    not @board[row][column]?

  _enemySquare: (row, column) ->
    piece = @board[row][column]
    # is it a piece, and is it not the player's colour 
    piece? and not new RegExp(@turn).test piece 

  _playerSquare: (row, column) ->
    piece = @board[row][column]
    # is it a piece, and is it the player's colour 
    piece? and new RegExp(@turn).test piece

module.exports = GameStore