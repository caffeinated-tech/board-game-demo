{ div } = React.DOM
Lobby = require('./lobby')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Lobby.store
    super(props)

  render: ->
    console.log 'lobby RootComponent'
    div {},
      Lobby @state, @props.children
    
module.exports = RootComponent