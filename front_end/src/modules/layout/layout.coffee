{ Link} = ReactRouter
Link = React.createFactory Link

{ div, ul, li } = React.DOM

class Layout extends React.Component
  render: ->
    console.log 'render the Layout'
    div {},
      'This is the Layout'
      div {},
        div { className: 'nav-bar' },
          ul {},
            li {},
              Link { to: '/' },
                'Home'
            li {},
              Link { to: '/game' },
                'Game'
            li {},
              Link { to: '/lobby' },
                'Lobby'
      div { className: 'content' },
        @props.children

module.exports = Layout