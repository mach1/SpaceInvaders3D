debug = require('debug')('t3tris')
app = require '../app.coffee'
config = require '../config.json'

port = Number config.port || 3000

server = app.listen port, ->
  debug 'Server running on port: ' + port

