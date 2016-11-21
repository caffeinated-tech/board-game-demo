{ div } = React.DOM

class Piece extends React.Component
  render: ->
    div { className: "piece #{@props.colour}"},
      @_type()

  @_type: ->
    ''

# We export the class as this is only an interface for other pieces to 
#   overwrite
module.exports = Piece