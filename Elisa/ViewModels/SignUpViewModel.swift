//
//  SignUpViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol SignUpViewModeling {
    
}

class SignUpViewModel: SignUpViewModeling {
    
    let authenticationAPIService = AuthenticationAPIService()
    
    lazy var signUp: Action<(String, String, String), AuthenticationStruct, ServerError> = {
        Action<(String, String, String), AuthenticationStruct, ServerError> { [unowned self] fullname, email, password in
            return self.authenticationAPIService.signup(fullname: fullname, email: email, password: password)
        }
    }()
    
}

