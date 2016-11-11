{ div } = React.DOM
Home = require('./components/home')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    console.log "CreateHome RootComponent"
    @store = App.Modules.Home.store
    super(props)

  render: ->
    console.log 'render the RootComponent contianter'
    div {},
      Home @state
    
module.exports = RootComponent