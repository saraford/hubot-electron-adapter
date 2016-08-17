Robot   = require('hubot').Robot
Adapter = require('hubot').Adapter
User = require('hubot').User
TextMessage = require('hubot').TextMessage
sendResponseToElectronApp = undefined

class Sample extends Adapter

  wireUpResponses: (functionToCall) ->
    console.log "Hello from Sample Adapter... setting up ElectronApp function"
    sendResponseToElectronApp = functionToCall

  send: (envelope, strings...) ->
    console.log "at the send:"
    console.log "envelope: " + envelope

    for str in strings
      sendResponseToElectronApp(str)
      console.log str

    @robot.logger.info "Send"

  emote: (envelope, strings...) ->
    console.log "at the emote"

    for str in strings
      sendResponseToElectronApp(str, true)
      console.log str

    @robot.logger.info "emote"

  reply: (envelope, strings...) ->

    username = ""
    for k,v of envelope.user
      if k == 'id'
        break
      else
        username = username + v

    console.log username

    for str in strings
      sendResponseToElectronApp("@#{username} " + str)
      console.log str

    @robot.logger.info "Reply"

  run: ->
    @robot.logger.info "Run"
    @emit "connected"
    user = new User 1001, name: 'Sample User'
    message = new TextMessage user, 'Some Sample Message', 'MSG-001'
    @robot.receive message


exports.use = (robot) ->
  new Sample robot
