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

# PUT /api/v2/me
AppServer.put '/api/v2/me', (env, callback) ->
  request = new AppServer.Request(env)
  request.params (error, params) ->
    body = JSON.stringify(new Factory('Me', params))
    AppServer.Response(body).send(callback)

# GET /api/v2/brands
brands = []
_(10).times (i) ->
  brand =
    id:                  "#{1230 + i}"
    slug:                "brand-#{i}"
    name:                "Brand-#{1230 +i}"
    logo:                "http://dummyimage.com/50x50/ccc/555.png&text=logo"
    action_count:        i*3
    actions_new:         (i-1)*3
    actions_in_progress: i*2
    actions_expiring:    i
    crowd_participant:   !(i%2)
  brands.push new Factory('Brand', brand)

AppServer.get '/api/v2/brands', (env, callback) ->
  body = JSON.stringify(brands)
  AppServer.Response(body).send(callback)

# GET /api/v2/brands/:id
AppServer.get '/api/v2/brands/:id', (env, callback) ->
  brand = new Factory('Brand')
  brand.id                 = env.route.id
  brand.name               = "#{brand.name}-#{brand.id}"
  brand.me.points          = 2500
  brand.me.entries         = 25
  brand.me.lifetime_points = 500000
  brand.me.rank            = 10

  body = JSON.stringify( brand )
  AppServer.Response(body).send(callback)

# Get /api/v2/charities
charities = []
_(4).times (i) ->
  charities.push new Factory('Charity', id: (i+1) * 4)
charities.push new Factory('Charity', id: 3, default: true)

AppServer.get '/api/v2/charities', (env, callback) ->
  AppServer.Response(JSON.stringify(charities)).send(callback)

# GET application.css
AppServer.get '/application.css', Portal.cssPackage().createServer()
# GET application.js
AppServer.get '/application.js', Portal.hemPackage().createServer()

AppServer.use(AppServer.file, root, 'index.html')
AppServer.run({ port: 9295 })

CopycopterServer = require 'strata'
#CopycopterServer.use(CopycopterServer.commonLogger)
CopycopterServer.use(CopycopterServer.contentType, 'application/json')
CopycopterServer.use(CopycopterServer.contentLength)
CopycopterServer.get '/translations', (env, callback) ->
  req = new CopycopterServer.Request(env)
  req.params (err, params) ->
    CopycopterServer.Response("#{params.callback}({ 'en': { } })").send(callback)
CopycopterServer.run({ port: 4004 })
