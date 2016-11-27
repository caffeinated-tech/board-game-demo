{ div } = React.DOM
Layout = require('./layout')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Layout.store
    super(props)

  render: ->
    div {},
      Layout @state, @props.children
    
module.exports = RootComponent