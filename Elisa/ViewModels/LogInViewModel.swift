//
//  LogInViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 8/23/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol LogInViewModeling {
    func logout() -> SignalProducer<Status, ConnectionError>
}

class LogInViewModel: LogInViewModeling {
    
    let authenticationAPIService = AuthenticationAPIService()
    
    lazy var login: Action<(String, String), AuthenticationStruct, ServerError> = {
        Action<(String, String), AuthenticationStruct, ServerError> { [unowned self] email, password in
            return self.authenticationAPIService.login(email, password: password)
        }
    }()
    
    func logout() -> SignalProducer<Status, ConnectionError> {
        return self.authenticationAPIService.logout()
    }
    
}
