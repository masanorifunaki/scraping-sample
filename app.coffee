express = require 'express'
path    = require 'path'
helmet  = require 'helmet'

routes  = require './routes/index'

app     = express()
app.use helmet()

# view engine setup
app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'pug'

app.use '/public', express.static path.join __dirname, 'public'

app.use '/', routes

app.listen process.env.PORT || 3000, ->
  console.info "Listening ..."