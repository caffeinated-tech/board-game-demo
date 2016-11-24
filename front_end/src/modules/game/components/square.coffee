{ div } = React.DOM

Rook = require './pieces/rook'
Knight = require './pieces/knight'
Bishop = require './pieces/bishop'
Queen = require './pieces/queen'
King = require './pieces/king'
Pawn = require './pieces/pawn'


class Square extends React.Component
  render: ->
    # alternate the colour of the square based on column and row:
    #   In an even column, every even square is black
    colourClass = if @props.column % 2 is @props.row % 2 
      'black'
    else
      'white'

    colourClass += ' valid-move' if @props.valid
    colourClass += ' selected' if @props.selected
    div 
      className: "square #{colourClass}"
      onClick: @_onClick
      ,
      @renderPiece @props.piece

  renderPiece: (piece) ->
    return null unless piece
    # split the piece id into it's type and colour
    [colour, type] = piece.split('_')
    # remove the number from the type
    type = type.replace(/\d/, '')

    pieceProps = 
      colour: colour
      id: piece

    switch type
      when 'rook' then Rook pieceProps 
      when 'knight' then Knight pieceProps 
      when 'bishop' then Bishop pieceProps 
      when 'queen' then Queen pieceProps 
      when 'king' then King pieceProps 
      when 'pawn' then Pawn pieceProps 

  _onClick: =>
    App.Modules.Game.actions.selectSquare @props.column, @props.row

module.exports = React.createFactory Square