{ div } = React.DOM
Home = require('./components/home')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Home.store
    super(props)

  render: ->
    div {},
      Home @state
    
module.exports = RootComponent