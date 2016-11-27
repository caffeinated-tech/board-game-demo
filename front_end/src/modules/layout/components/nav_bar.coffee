{ div, ul, li, a, span } = React.DOM
Link = React.createFactory ReactRouter.Link


class NavBar extends React.Component
  render: ->
    console.log 'update props', @props.user
    console.log 'user', @props.user?
    div { className: 'pure-menu pure-menu-horizontal' },
      ul { className: 'pure-menu-list' },
        li { className: 'pure-menu-heading logo' },
          'React \u2713'
        li { className: 'pure-menu-item' },
          Link { to: '/' , className: 'pure-menu-link' },
            'Home'
        if @props.user?
          span {},  
            if @props.user.game
              li { className: 'pure-menu-item' },
                Link { to: "/game/#{@props.user?.game?.id}" , className: 'pure-menu-link' },
                  'Game'
            li { className: 'pure-menu-item' },
              Link { to: '/lobby' , className: 'pure-menu-link' },
                'Lobby'
            li { className: 'pure-menu-item' },
              a { href: '/logout', className: 'pure-menu-link' },
                'Logout'
      
module.exports = React.createFactory NavBar