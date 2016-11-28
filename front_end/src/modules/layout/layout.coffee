{ div, ul, li } = React.DOM

NavBar = require('./components/nav_bar')

class Layout extends React.Component

  render: ->
    div {},
      NavBar @props
      div { className: 'content' },
        @props.children

module.exports = React.createFactory Layout