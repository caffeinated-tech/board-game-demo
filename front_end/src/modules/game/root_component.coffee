{ div } = React.DOM

Game = require('./game')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Game.store
    super(props)

  render: ->
    div {},
      Game @state, @props.children
    
module.exports = RootComponent