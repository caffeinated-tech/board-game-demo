{ div, ul, li } = React.DOM

NavBar = require('./components/nav_bar')

class Layout extends React.Component

  render: ->
    div {},
      NavBar()
      div { className: 'content' },
        @props.children

module.exports = Layout