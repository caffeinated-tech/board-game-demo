{ div } = React.DOM

class GameList extends React.Component
  render: ->
    div {},
      "List of #{@props.display.filter} Games"
      
module.exports = React.createFactory GameList