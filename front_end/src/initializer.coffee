component = require './root_component'
SELECTOR = '#react'

Initializer =
  mount: ->
    ReactDOM.render(
      component(),
      document.querySelector SELECTOR
    )
  unmount: ->
    unmountComponentAtNode

module.exports = Initializer