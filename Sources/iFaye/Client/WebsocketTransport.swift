//
//  WebsocketTransport.swift
//
//
//  Created by Nikhil John on 29/12/20.
//

import Foundation
import Starscream

class WebsocketTransport: Transport {
    var urlString:String?
    var webSocket:WebSocket?
    var headers: [String: String]? = nil
    weak var delegate:TransportDelegate?
    private var socketConnected: Bool = false

    var isConnected: Bool {
        return socketConnected
    }

    convenience required internal init(url: String) {
        self.init()

        self.urlString = url
    }

    func openConnection() {
        self.closeConnection()
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                print("Faye: Invalid url")
                return
        }
        var urlRequest = URLRequest(url: url)
        if let headers = self.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        self.webSocket = WebSocket(request: urlRequest)

        if let webSocket = self.webSocket {
            webSocket.delegate = self
            webSocket.connect()
            print("Faye: Opening connection with \(String(describing: self.urlString))")
        }
    }

    func closeConnection() {
        if let webSocket = self.webSocket {
            print("Faye: Closing connection")

            webSocket.delegate = nil
            webSocket.disconnect()

            self.webSocket = nil
        }
    }

    func writeString(_ aString:String) {
        self.webSocket?.write(string: aString)
    }

    func sendPing(_ data: Data, completion: (() -> ())? = nil) {
        self.webSocket?.write(ping: data, completion: completion)
    }

    func websocketDidDisconnect(withReason reason: String?, andCode code: UInt16?) {
        if let reason = reason,
            let code = code {
            self.delegate?.didDisconnect(.connectionLost(reason: reason, code: code))
        } else {
            self.delegate?.didDisconnect(.connectionDisconnected)
        }
    }
}

extension WebsocketTransport: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            socketConnected = true
            print("Faye: Websocket is connected: \(headers)")
            self.delegate?.didConnect()
        case .disconnected(let reason, let code):
            socketConnected = false
            print("Faye: Websocket is disconnected: \(reason) with code: \(code)")
            websocketDidDisconnect(withReason: reason, andCode: code)
        case .text(let text):
            print("Faye: Received text: \(text)")
            self.delegate?.didReceiveMessage(text)
        case .binary(let data):
            print("Faye: Received data: \(data.count)")
            self.delegate?.didReceiveData(data)
        case .ping(_):
            self.delegate?.didReceivePing()
            break
        case .pong(_):
            self.delegate?.didReceivePong()
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            socketConnected = false
            break
        case .error(let error):
            socketConnected = false
            handleError(error)
            break
        }
    }
    
    func handleError(_ error: Error?) {
        print(error?.localizedDescription ?? "Unknown Error")
    }
}
