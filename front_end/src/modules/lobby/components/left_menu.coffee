{ div, ul, li, span } = React.DOM
Link = React.createFactory ReactRouter.Link

class LeftMenu extends React.Component
  render: ->
    div { className: 'pure-menu fixed-left' },
      span { className: 'pure-menu-heading' },
        'Options'
      ul { className: 'pure-menu-list' },
        li { className: 'pure-menu-item' },
          Link { to: '/lobby/create', className: 'pure-menu-link'}, 
            "Create Game"
        li { className: 'pure-menu-item' },
          Link { to: '/lobby/games/open', className: 'pure-menu-link'}, 
            "Open Games"
        li { className: 'pure-menu-item' },
          Link { to: '/lobby/games/closed', className: 'pure-menu-link'}, 
            "Closed games"
        li { className: 'pure-menu-item' },
          Link { to: '/lobby/players', className: 'pure-menu-link'}, 
            "Players"

module.exports = React.createFactory LeftMenu