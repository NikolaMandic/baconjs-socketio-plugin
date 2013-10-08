init = (Bacon, io) ->
  Bacon.socketio = asEventStream: (eventName) ->
    Bacon.fromBinder (handler) =>
      @on(eventName, handler)
      => @off(eventName, handler)
  
  (io ? null)?.SocketNamespace.prototype.asEventStream = Bacon.socketio.asEventStream 

if module?
  Bacon = require("baconjs")
  io = require("socketio")
  module.exports = init(Bacon, io)
else
  if typeof require is "function"
    define "bacon-socketio", ["bacon", "socket.io"], init
  else
    init(this.Bacon, this.io)
