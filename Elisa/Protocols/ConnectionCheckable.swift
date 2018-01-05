//
//  ConnectionCheckable.swift
//  Bitesized
//
//  Created by Marek Fořt on 10/21/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import Reachability

protocol ConnectionCheckable: class {
    var isOffline: Bool {get set}
    var reconnectedCompletion: (() -> ())? {get}
    var reachability: Reachability {get}
    func checkConnection()
}

extension ConnectionCheckable where Self: ResponseShowable {
    func checkConnection() {
        
        reachability.whenUnreachable = { [weak self] _ in
            self?.showResponse(succeeded: false, title: L10n.Connection.checkConnection, asset: Asset.connectionError)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func reactToReachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        if reachability.connection == .none {
            isOffline = true
            showResponse(succeeded: false, title: L10n.Connection.checkConnection, asset: Asset.connectionError)
        }
        else {
            guard isOffline else {return}
            reconnectedCompletion?()
            isOffline = false
        }
    }
    
    
}
