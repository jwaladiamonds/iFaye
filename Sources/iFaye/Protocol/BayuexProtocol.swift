//
//  BayuexProtocol.swift
//  
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation

// MARK: Bayuex Connection Type
public enum BayeuxConnection: String {
    case LongPolling = "long-polling"
    case Callback = "callback-polling"
    case iFrame = "iframe"
    case WebSocket = "websocket"
}

// MARK: BayuexChannel Messages
public enum BayeuxChannel: String, Encodable, Equatable{
    case Handshake = "/meta/handshake"
    case Connect = "/meta/connect"
    case Disconnect = "/meta/disconnect"
    case Subscribe = "/meta/subscribe"
    case Unsubscibe = "/meta/unsubscribe"
}

// MARK: Bayuex Parameters
public enum Bayeux: String {
    case Channel = "channel"
    case Version = "version"
    case ClientId = "clientId"
    case ConnectionType = "connectionType"
    case Data = "data"
    case Subscription = "subscription"
    case Id = "id"
    case MinimumVersion = "minimumVersion"
    case SupportedConnectionTypes = "supportedConnectionTypes"
    case Successful = "successful"
    case Error = "error"
    case Advice = "advice"
}
