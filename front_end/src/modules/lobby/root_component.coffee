{ div } = React.DOM
Lobby = require('./components/Lobby')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Lobby.store
    super(props)

  render: ->
    div {},
      Lobby @state, @props.children
    
module.exports = RootComponent