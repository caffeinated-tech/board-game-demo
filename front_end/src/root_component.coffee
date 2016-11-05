{ Router, Route, Link, browserHistory, IndexRedirect } = ReactRouter
# for some reason reactrouter doesn't export factories, so let's convert them
Router = React.createFactory Router
Route = React.createFactory Route
Link = React.createFactory Link
IndexRedirect = React.createFactory IndexRedirect

class RootComponent extends React.Component
  render: ->
    Router 
      history: browserHistory
      ,
      Route
        path: '/'
        component: App.Modules.Layout.component
        ,
        IndexRedirect 
          to: '/home'
        Route 
          path: '/home'
          component: App.Modules.Home.component
        Route 
          path: '/game'
          component: App.Modules.Game.component
        Route 
          path: '/lobby'
          component: App.Modules.Lobby.component

module.exports = RootComponent