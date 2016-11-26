{ table, thead, tr, th, tbody, td } = React.DOM

GameRow = require './game_row'

class List extends React.Component
  render: -> 
    table { className: 'pure-table' },
      thead {},
        tr {},
          th {},
            'Created at'
          th {},
            'White Player'
          th {},
            'Black Player'
          th {},
            'Action'
      tbody {},
        for game in @props.games
          GameRow 
            game: game
            key: game.id
            
module.exports = React.createFactory List