//
//  SubscriptionProtocol.swift
//
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation

// MARK: Subscription State
public enum FayeSubscriptionState {
    case pending(FayeSubscriptionModel)
    case subscribed(FayeSubscriptionModel)
    case queued(FayeSubscriptionModel)
    case subscribingTo(FayeSubscriptionModel)
    case unknown(FayeSubscriptionModel?)
}

// MARK: Type Aliases
public typealias ChannelSubscriptionBlock = (NSDictionary) -> Void


public struct FayeSubscriptionModel: Encodable, Equatable {
    
    /// Subscription URL
    let subscription: String
    
    /// Channel type for request
    let channel: BayeuxChannel
    
    /// Uniqle client id for socket
    var clientId: String?
    
    /// Model must conform to Hashable
    var hashValue: Int {
        return subscription.hashValue
    }
    
    public init(subscription: String, channel: BayeuxChannel, clientId: String?) {
        self.subscription = subscription
        self.channel = channel
        self.clientId = clientId
    }
}

extension String {
    func encodeToBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
