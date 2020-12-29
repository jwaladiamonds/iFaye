//
//  TransportProtocol.swift
//
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation

public enum DisconnectionType {
    case connectionLost(reason: String, code: UInt16)
    case connectionDisconnected
}

public protocol Transport {
    func writeString(_ aString:String)
    func openConnection()
    func closeConnection()
    var isConnected: Bool { get }
}

public protocol TransportDelegate: class {
    func didConnect()
    func didDisconnect(_ type: DisconnectionType?)
    func didWriteError(_ error: NSError?)
    func didReceiveMessage(_ text: String)
    func didReceiveData(_ data: Data)
    func didReceivePong()
    func didReceivePing()
}
