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
    unmountComponentAtNode document.querySelector SELECTOR
  
  populateStores: ->
    if gon.user?
      App.Modules.Home.store.loadUser gon.user


module.exports = Initializer