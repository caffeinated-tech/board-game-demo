{ div } = React.DOM

class Piece extends React.Component
  render: ->
    console.log 'render a piece', @props
    div {},
      'This is a piece'

# We export the class as this is only an interface for other pieces to 
#   overwrite
module.exports = Piece