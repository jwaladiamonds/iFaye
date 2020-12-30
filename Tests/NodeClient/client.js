const faye      = require('faye'),
      Auth      = require('./auth'),
      endpoint  = "https://ws.gitter.im/bayeux",
      token     = "TOKEN", // Replace this with your token
      roomId    = "5fbea507d73408ce4ff4f0f8" // RoomID of https://gitter.im/Gitter-iOS-App/community

console.log('Connecting to ' + endpoint)

const client = new faye.Client(endpoint)

client.addExtension(new Auth(client, token, roomId))

const subscription = client.subscribe('/api/v1/rooms/' + roomId + '/chatMessages', function(message) {
  console.log(message)
})

subscription.callback(function() {
  console.log('[SUBSCRIBE SUCCEEDED]')
})
subscription.errback(function(error) {
  console.log('[SUBSCRIBE FAILED]', error)
})

client.bind('transport:down', function() {
  console.log('[CONNECTION DOWN]')
})
client.bind('transport:up', function() {
  console.log('[CONNECTION UP]')
})
