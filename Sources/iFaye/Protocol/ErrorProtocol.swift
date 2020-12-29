//
//  ErrorProtocol.swift
//  
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation

public enum SubscriptionError: Error {
    case error(subscription: String, error: String)
}

public enum FayeSocketError {
    case lostConnection, transportWrite
}

public extension NSError {
    
    // MARK:
    // MARK: Error
    
    /// Helper to create a error object for faye realted issues
    convenience init(error: FayeSocketError) {
        self.init(domain: "diamonds.jwala.ifaye", code: 10000, userInfo: nil)
    }
}
