
GameStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @game = null
    @player = null
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
    console.log 'onSetPlayer'
    @player = user 
    if not @game? and user.game?
      @game = user.game
      @_setPlayerColour()
      @_initializeGame()
    # if there is no game, redirect the player to the create game view
    unless @game?
      ReactRouter.browserHistory.push "/lobby/create"
    @update()

  onApiGetUpdatesCompleted: (move) ->
    if move
      console.log 'enemy made a move', move.from.piece
      @_replayMove(move)
      @game.moves.push move 
      @_nextPlayer()
      @update()
    else
      setTimeout @_checkForEnemyMove, 1000


  onApiGetUpdatesFailed: (error) ->
    setTimeout @_checkForEnemyMove, 3000

  onApiForfeitCompleted: (game) ->
    @game = game
    @update()
    window.alert("You have lost the game")

  props: ->
    turn: @turn
    game: @game
    display: @display
    board: @board
    player: @player
    validMoves: @validMoves
    check: @check
    selectedSquare: "#{@firstSquare.row}#{@firstSquare.column}" if @firstSquare?

  _initializeGame: ->
    @board = SetupStartingPieces() 
    @_replayMove(move) for move in @game.moves

    # after applying the moves, count them. Black takes odd moves, white 
    #   takes even moves. but we set it to the opposite, then run the code for
    #   updating the turn which checks for check
    @turn = if @game.moves.length % 2 is 0
      'black'
    else
      'white'

    @_nextPlayer()

  _replayMove: (move) ->
    @firstSquare = move.from
    @secondSquare = move.to
    @_makeMove()

  _setFirstSquare: (column, row) ->
    return unless @_isMyTurn()
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
    @_markValidMoves(@firstSquare)
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
    @_nextPlayer()
    @update()

  _recordMove: ->
    console.log 'record move'
    # record move on server 
    # TODO: order needs to be guaranteed
    @game.moves.push
      from: @firstSquare
      to: @secondSquare
    console.log 'move is ', @game.moves.length
    App.Modules.Game.actions.apiMove
      gameId: @game.id
      from: @firstSquare
      to: @secondSquare

  _makeMove: ->
    console.log 'make move'
    # remove piece from first square
    @board[@firstSquare.row][@firstSquare.column] = null
    # place piece from first to second square
    @board[@secondSquare.row][@secondSquare.column] = @firstSquare.piece
    # reset selected squares after move
    @_resetSelectedSquares()

  _nextPlayer: ->
    console.log 'next player'
    @_checkIfGameOver()
    @_checkIfInCheck() # needs to run before we switch to the next user
    @turn = if @turn is 'white' then 'black' else 'white'
    return if @game.local or @_isMyTurn()
    @_checkForEnemyMove()

  _checkForEnemyMove: ->
    # it is the enemies turn, we need to check the server to see if they made 
    #   a move
    App.Modules.Game.actions.apiGetUpdates
      gameId: @game.id
      nextMove: @game.moves.length 

  _isMyTurn: -> 
    @game.local or @turn is @player.colour

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

  _markValidMoves: (piece) ->
    if /pawn/.test piece.piece
      @_markValidMovesForPawn(piece.row, piece.column)
    else if /rook/.test piece.piece
      @_markValidMovesForRook(piece.row, piece.column)
    else if /knight/.test piece.piece
      @_markValidMovesForKnight(piece.row, piece.column)
    else if /bishop/.test piece.piece
      @_markValidMovesForBishop(piece.row, piece.column)
    else if /king/.test piece.piece
      @_markValidMovesForKing(piece.row, piece.column)
    else if /queen/.test piece.piece
      @_markValidMovesForQueen(piece.row, piece.column)
    else
      false

  _markValidMovesForPawn: (row, col) ->
    direction = if @turn is 'white' then -1 else 1 

    # can move forward unless there is a piece in that spot
    if @_emptySquare(row + direction, col)
      @validMoves.push "#{row+direction}#{col}"
    # starting row means we can move forward by two
    if @turn is 'white'
      if row is 6 and @_emptySquare(row+(direction*2), col) and
         @_emptySquare(row + direction,col) 
        @validMoves.push "#{row+(direction*2)}#{col}"
    else
      if row is 1 and @_emptySquare(row+(direction*2), col) and
         @_emptySquare(row + direction,col) 
        @validMoves.push "#{row+(direction*2)}#{col}"
    # now check for pieces in the diagonal locaitons which can be taken
    if @_enemySquare(row + direction, col-1)
      @validMoves.push "#{row+direction}#{col-1}"
    if @_enemySquare(row + direction, col+1)
      @validMoves.push "#{row+direction}#{col+1}"

  _markValidMovesForRook: (row, col) ->
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

  _markValidMovesForKnight: (row, col) ->
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

  _markValidMovesForBishop: (row, col) ->
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

  _markValidMovesForKing: (row, col)->
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

  _markValidMovesForQueen: (row, col) ->
    @_markValidMovesForRook(row, col)
    @_markValidMovesForBishop(row, col)

  # we check at the start of each users turn if their king is in check
  _checkIfInCheck: ->
    enemyKing = null
    for row,rowCount in @board
      for piece, colCount in row
        continue if not piece?
        if @_pieceIsUserColour(piece)
          @_markValidMoves 
            piece: piece
            row: rowCount
            column: colCount
        else
          # If it's the enemies king, save the co-ords for later 
          enemyKing = "#{rowCount}#{colCount}" if /king/.test piece
    # @validMoves array is now fully populated wit hall moves I can 
    #   make, now check if the enemy king is in one of these squares
    if enemyKing in @validMoves
      @check = enemyKing
    else 
      @check = null
    # comment this line to see how check works
    @validMoves = []

  _checkIfGameOver: ->
    [..., lastMove] = @game.moves
    lastMoveTakenPiece = lastMove.to.piece
    return unless /king/.test lastMove.to.piece

    winningColour = lastMove.from.piece.split('_')[0]
    console.log "the game was won by '#{winningColour}"
    if @game.local
      alert("#{winningColour} has won the game!")
    else
      if @player.colour is winningColour
        alert("Congratulations, you won the game!")
      else
        alert("Bad luck, you lost this one.\nBetter luck next time")

    App.Modules.Game.actions.apiWonGame 
      gameId: @game.id
      colour: winningColour

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