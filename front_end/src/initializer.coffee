SELECTOR = '#react'
component = React.createFactory require('./root_component')

Initializer =
  mount: ->
    ReactDOM.render(
      component(),
      document.querySelector SELECTOR
    )
  unmount: ->
    unmountComponentAtNode

module.exports = Initializer