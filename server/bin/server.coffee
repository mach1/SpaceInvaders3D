debug = require('debug')('t3tris')
app = require '../app.coffee'
config = require '../config.json'

port = process.env.port || 5000
console.log port

server = app.listen port, ->
  debug 'Server running on port: ' + port

