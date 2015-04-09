debug = require('debug')('space-invaders')
app = require '../app.coffee'
config = require '../config.json'

port = process.env.PORT || 5000

server = app.listen port, ->
  debug 'Server running on port: ' + port

