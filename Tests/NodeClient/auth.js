class Auth {
  constructor(client, token) {
    this.client = client
    this.token = token
    this.authProvider = function(callback) {
      return callback({
        token: this.token
      })
    }
  }

  incoming = (message, callback) => {
    console.log("Receiving ====>")
    console.log(message)
    if (message.channel == '/meta/handshake') {
      if (message.successful) {
        console.log('Successfuly subscribed to room')
      } else {
        console.log('Something went wrong: ', message.error)
      }
    }
    callback(message)
  }

  outgoing = (message, callback) => {
    console.log("<==== Sending")
    console.log(message)
    if (message.channel == '/meta/handshake') {
      if (!message.ext) {
        message.ext = {}
      }
      message.ext.token = this.token
    }
    callback(message)
  }
}

module.exports = Auth
