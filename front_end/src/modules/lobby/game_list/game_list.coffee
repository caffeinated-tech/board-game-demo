{ div, br } = React.DOM
{ Link } = ReactRouter

Link = React.createFactory Link
List = require './components/list'

class GameList extends React.Component
  render: -> 
    console.log 'render GameList', @props 
    div {},
      if @props.games.length is 0
        div {},
          "There are no #{@props.display.filter} games, why not "
          br {}
          Link { to: '/lobby/create' },
            'create a new game'
      else
        List @props

module.exports = React.createFactory GameList