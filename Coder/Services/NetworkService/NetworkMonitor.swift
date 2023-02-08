//
//  NetworkMonitor.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 19.01.2023.
//

import Foundation
import Network

final class NetworkMonitor {
    
    // MARK: - Properties
    
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private(set) var isConnected: Bool = true
    
    private(set) var interfaceType: NWInterface.InterfaceType?
    private init() {
        self.monitor = NWPathMonitor()
    }
}

// MARK: - Public Methods

extension NetworkMonitor {
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.interfaceType = NWInterface.InterfaceType.allCases.filter {
                path.usesInterfaceType($0)
            }.first
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

// MARK: - Interface Type

extension NWInterface.InterfaceType: CaseIterable {
    
    public static var allCases: [NWInterface.InterfaceType] = [
        .wiredEthernet,
        .wifi,
        .cellular,
        .loopback,
        .other
    ]
}


