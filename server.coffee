require './spec/factories'
{Factory} = require 'forgery'
AppServer = require 'strata'
path      = require 'path'
Hem       = require 'hem'
root      = path.resolve("./public")

AppServer.use(AppServer.commonLogger)
AppServer.use(AppServer.contentType, 'application/json')
AppServer.use(AppServer.contentLength)

Portal = new Hem()

less = require('hem-less')
less.setOptions { compress: false }
Portal.compilers.less = less.compiler

# GET /api/v2/me
AppServer.get '/api/v2/me', (env, callback) ->
  body = JSON.stringify(new Factory('Me'))
  AppServer.Response(body).send(callback)

# GET application.css
AppServer.get '/application.css', Portal.cssPackage().createServer()
# GET application.js
AppServer.get '/application.js', Portal.hemPackage().createServer()

AppServer.use(AppServer.file, root, 'index.html')
AppServer.run({ port: 9294 })

CopycopterServer = require 'strata'
#CopycopterServer.use(CopycopterServer.commonLogger)
CopycopterServer.use(CopycopterServer.contentType, 'application/json')
CopycopterServer.use(CopycopterServer.contentLength)
CopycopterServer.get '/translations', (env, callback) ->
  req = new CopycopterServer.Request(env)
  req.params (err, params) ->
    CopycopterServer.Response("#{params.callback}({ 'en': { } })").send(callback)
CopycopterServer.run({ port: 3004 })
