{ div } = React.DOM

class Square extends React.Component
  render: ->
    colourClass = if @props.column % 2 is @props.row % 2 
      'black'
    else
      'white'
    div { className: "square #{colourClass}" },
      "#{@props.row} - #{@props.column}"

module.exports = React.createFactory Square