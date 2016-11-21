{ div } = React.DOM

Rook = require './pieces/rook'
Knight = require './pieces/knight'
Bishop = require './pieces/bishop'
Queen = require './pieces/queen'
King = require './pieces/king'
Pawn = require './pieces/pawn'


class Square extends React.Component
  render: ->
    colourClass = if @props.column % 2 is @props.row % 2 
      'black'
    else
      'white'
    div { className: "square #{colourClass}" },
      @renderPiece @props.piece

  renderPiece: (piece) ->
    console.log  "piece", piece
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

module.exports = React.createFactory Square