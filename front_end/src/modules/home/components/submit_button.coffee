{ button } = React.DOM 

class SubmitButton extends React.Component
  render: ->
    button 
      className: 'submit'
      onClick: @props.onClick
      @props.children
        
module.exports = React.createFactory SubmitButton