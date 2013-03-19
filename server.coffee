require './spec/factories'
{Factory} = require 'forgery'
AppServer = require 'strata'
_         = require 'underscore'
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

# GET /api/v2/brands
brands = []
_(10).times (i) ->
  brand =
    id:           "#{1230 + i}"
    slug:         "brand-#{i}"
    name:         "Brand-#{1230 +i}"
    logo:         "http://dummyimage.com/50x50/ccc/555.png&text=logo"
    action_count: 3*i
  brands.push new Factory('Brand', brand)

AppServer.get '/api/v2/brands', (env, callback) ->
  body = JSON.stringify(brands)
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
