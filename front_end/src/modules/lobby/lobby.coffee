{ div, h2 } = React.DOM
LeftMenu = require('./components/left_menu')


class Lobby extends React.Component
  render: ->
    div { id: 'lobby' },
      LeftMenu @props
      div { className: 'content' },
        h2 {},
          'This is the Lobby'
        @props.children

module.exports = React.createFactory Lobby