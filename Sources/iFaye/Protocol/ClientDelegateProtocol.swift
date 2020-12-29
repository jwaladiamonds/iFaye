//
//  ClientDelegateProtocol.swift
//
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation

// MARK: FayeClientDelegate Protocol
public protocol FayeClientDelegate: NSObjectProtocol {
    func messageReceived(_ client:FayeClient, messageDict: NSDictionary, channel: String)
    func pongReceived(_ client:FayeClient)
    func pingReceived(_ client:FayeClient)
    func connectedToServer(_ client:FayeClient)
    func disconnectedFromServer(_ client:FayeClient)
    func connectionFailed(_ client:FayeClient)
    func didSubscribeToChannel(_ client:FayeClient, channel:String)
    func didUnsubscribeFromChannel(_ client:FayeClient, channel:String)
    func subscriptionFailedWithError(_ client:FayeClient, error:SubscriptionError)
    func fayeClientError(_ client:FayeClient, error:NSError)
}
