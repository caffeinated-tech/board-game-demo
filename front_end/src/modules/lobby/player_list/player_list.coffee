{ div } = React.DOM

class PlayerList extends React.Component
  render: ->
    div {},
      "List of Players"
      
module.exports = React.createFactory PlayerList