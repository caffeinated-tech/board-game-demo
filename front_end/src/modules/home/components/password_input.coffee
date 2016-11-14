{ div, input, label } = React.DOM

Error = require('./error')

class PasswordInput extends React.Component
  render: ->
    div { className: 'pure-control-group' },
      label {},
        'Password '
      input
        ref: 'password'
        type: 'password'
        placeholder: 'Password'
      if @props.form.errors.wrongPassword
        Error {},
          'Incorrect Password'
      if @props.form.errors.passwordMissing
        Error {},
          'Please enter a password'

  componentDidMount: ->
    App.Modules.Home.actions.registerComponents
      password: @refs.password

module.exports = React.createFactory PasswordInput