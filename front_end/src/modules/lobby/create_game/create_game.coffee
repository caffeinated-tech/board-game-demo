{ div, form, fieldset, label, input, a, h3, span } = React.DOM

class CreateGame extends React.Component
  render: ->
    div {},
      h3 {},
        'Create a new Game'
      form { className: 'pure-form pure-form-aligned' },
        fieldset {},
          span {},
            'Which colour will you play as?' 
          div { className: 'pure-control-group white-or-black'},
            label { className: 'pure-radio white' },
              input 
                type: 'radio'
                name: 'player'
                value: 'white'
                ref: 'white' 
                defaultChecked: true
              'White'
            label { className: 'pure-radio black' },
              input 
                type: 'radio'
                name: 'player'
                value: 'black' 
              'Black'
          span {},
            'Are you planning on playing with a specific person? (Disabled)' 
          div { className: 'pure-control-group' },
            label {},
              'Private Game'
            input 
              type: 'checkbox'
              value: 'private'
              ref: 'private'
              defaultValue: false
              disabled: true
              title: 'disabled'
          span {},
            'If you want to play on a single device, tick this box' 
          div { className: 'pure-control-group' },
            label {},
              'Local Game'
            input 
              type: 'checkbox'
              value: 'local'
              ref: 'local'
          div { className: 'pure-controls' },
            a
              className: 'pure-button pure-button-primary'
              onClick: @onClick
              'Create Game'

  onClick: =>
    App.Modules.Lobby.CreateGame.actions.apiNewGame
      white: @refs.white.checked
      private_game: @refs.private.checked
      local: @refs.local.checked
      
module.exports = React.createFactory CreateGame