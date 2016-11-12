{ div, input, label } = React.DOM

Error = require('./error')

class PasswordInput extends React.Component
  render: ->
    div {},
      label {},
        'Password'
      input {}
      if @props.form.errors.wrongPassword
        Error {},
          'Incorrect Password '

module.exports = React.createFactory PasswordInput