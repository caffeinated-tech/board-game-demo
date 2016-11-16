{ Router, Route, Link, browserHistory, IndexRoute } = ReactRouter
# for some reason reactrouter doesn't export factories, so let's convert them
Router = React.createFactory Router
Route = React.createFactory Route
Link = React.createFactory Link
IndexRoute = React.createFactory IndexRoute

class RootComponent extends React.Component

  render: ->
    console.log 'component: App.Modules.Lobby.rootComponent'
    console.log component: App.Modules.Lobby.rootComponent

    Router 
      history: browserHistory
      ,
      Route
        path: '/'
        component: App.Modules.Layout.component
        ,
        IndexRoute
          component: App.Modules.Home.rootComponent
        Route 
          path: '/game'
          component: App.Modules.Game.component
        Route 
          path: '/lobby'
          component: App.Modules.Lobby.rootComponent
          ,
          Route
            path: '/lobby/create'
            component: App.Modules.Lobby.CreateGame.rootComponent 


module.exports = RootComponent