console.log 'hello world'

# load libraries
window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.ReactRouter = require 'react-router'
window.Reflux = require 'reflux'
window.ReactDnD = require 'react-dnd'

require('./monkey_patches')()

# load modules
window.App = 
  Modules: require './modules/module'
  Initializer: require './initializer'


window.App.Initializer.mount()