hooks = ->
  @Before "@startServer", "", ->
    console.log 'k'

module.exports = hooks
