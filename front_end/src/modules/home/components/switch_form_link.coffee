{ span } = React.DOM

class SwitchForm extends React.Component
  render: ->
    span 
      className: 'pure-button' 
      onClick: App.Modules.Home.actions.switchForm
      ,
      @props.children

module.exports = React.createFactory SwitchForm