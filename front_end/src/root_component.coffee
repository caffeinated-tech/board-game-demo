{ div } = React.DOM

class Root extends React.Component
  render: ->
  	div {},
  		Game.Modules.Game.component()

module.exports = React.createFactory Root