//
//  NetworkMonitor.swift
//  taskThirdwayv
//
//  Created by mohsen on 14/12/2022.
//

import Foundation
import Network
final class NetworkMonitor{
    static let shared = NetworkMonitor()
    
    
    private let queue = DispatchQueue.global()
    private let mintor:NWPathMonitor
    
    public private(set) var isConnected:Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        mintor = NWPathMonitor()
    }
    
    public func startMontiring(){
        mintor.start(queue: queue)
        mintor.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMontiring(){
        mintor.cancel()
    }
    
    private func getConnectionType(_ path : NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else   if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else   if path.usesInterfaceType(.other){
            connectionType = .ethernet
        }else{
            connectionType = .unknown
        }
        
    }
}
