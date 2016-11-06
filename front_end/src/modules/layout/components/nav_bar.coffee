{ div, ul, li } = React.DOM
Link = React.createFactory ReactRouter.Link


class NavBar extends React.Component
  render: ->
    div { className: 'nav-bar' },
      ul {},
        li { className: 'logo' },
          'React-Check'
        li {},
          Link { to: '/' },
            'Home'
        li {},
          Link { to: '/game' },
            'Game'
        li {},
          Link { to: '/lobby' },
            'Lobby'
      
module.exports = React.createFactory NavBar