{ div, a, h2, ul, li, span } = React.DOM
Link = React.createFactory ReactRouter.Link

class Lobby extends React.Component
  render: ->
    console.log 'render the Lobby', @props
    div { id: 'lobby' },
      div { className: 'pure-menu fixed-left' },
        span { className: 'pure-menu-heading' },
          'Options'
        ul { className: 'pure-menu-list' },
          li { className: 'pure-menu-item' },
            Link { to: '/lobby/create', className: 'pure-menu-link'}, 
              "create a new game"
      div { className: 'content' },
        h2 {},
          'This is the Lobby'
        @props.children

module.exports = Lobby