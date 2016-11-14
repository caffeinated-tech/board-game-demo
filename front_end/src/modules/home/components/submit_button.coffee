{ a } = React.DOM 

class SubmitButton extends React.Component
  render: ->
    a
      className: 'pure-button pure-button-primary'
      onClick: @onClick
      @props.children

  onClick: =>
    @props.onClick()
    console.log 'clicked'
    false
        
module.exports = React.createFactory SubmitButton