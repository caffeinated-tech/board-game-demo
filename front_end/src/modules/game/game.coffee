{ div } = React.DOM

Board = require './components/board'

class Game extends React.Component
  render: ->
    div {},
      Board @props

module.exports = React.createFactory Game