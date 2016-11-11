SELECTOR = '#react'
component = React.createFactory require('./root_component')

Initializer =
  mount: ->
    ReactDOM.render(
      component(),
      document.querySelector SELECTOR
    )
  
  connectStores: ->
    App.Modules.Home.store.registerListeners()

  unmount: ->
    unmountComponentAtNode

module.exports = Initializer