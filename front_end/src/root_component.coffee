{ Router, Route, Link, browserHistory } = ReactRouter
# for some reason reactrouter doesn't export factories, so let's convert them
Router = React.createFactory Router
Route = React.createFactory Route
Link = React.createFactory Link
{ div } = React.DOM

class RootComponent extends React.Component
  render: ->
    Game = React.createElement(App.Modules.Game.component) 

    div {},
      Router 
        history: browserHistory
        ,
        Route 
          path: '/'
          component: App.Modules.Game.component

module.exports = RootComponent