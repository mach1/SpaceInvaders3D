express = require 'express'
livereload = require 'connect-livereload'

router = express.Router()
bodyParser = require 'body-parser'

app = express()

app.use livereload()
app.use express.static(__dirname + '/../webapp/dist')
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended : true

app.use(router)

module.exports = app
