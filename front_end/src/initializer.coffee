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

  loadCSRF: ->
    token = document.querySelector(
      'meta[name="csrf-token"]').getAttribute('content')
    App.Helpers.Cookies.write 'csrf', token
    console.log "csrf=#{token}"

module.exports = Initializer