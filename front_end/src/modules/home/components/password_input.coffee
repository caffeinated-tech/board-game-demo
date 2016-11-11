{ div, input, label } = React.DOM

class PasswordInput extends React.Component
  render: ->
    div {},
      label {},
        'Password'
      input {}


module.exports = React.createFactory PasswordInput