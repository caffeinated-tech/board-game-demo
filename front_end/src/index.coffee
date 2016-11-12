console.log 'hello world'

# load libraries
window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.ReactRouter = require 'react-router'
window.Reflux = require 'reflux'
window.Promise = require 'bluebird'
window.ReactDnD = require 'react-dnd'

require('./monkey_patches')()

# load modules
window.App = {} 
window.App.Helpers =  require './helpers/helper'
window.App.Modules = require './modules/module'
window.App.Initializer = require './initializer'


window.App.Initializer.connectStores()
window.App.Initializer.mount()
window.App.Initializer.loadCSRF()