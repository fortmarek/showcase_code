//
//  SignUpStruct.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation


struct AuthenticationStruct {
    let credentials: Credentials
    let status: String
    let user: User
    
    init(credentials: Credentials, status: String, user: User) {
        self.credentials = credentials
        self.status = status
        self.user = user
    }
}

extension AuthenticationStruct: Decodable {
    enum SignUpStructKeys: String, CodingKey {
        case credentials = "credentials"
        case status = "status"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SignUpStructKeys.self)
        let credentials: Credentials = try container.decode(Credentials.self, forKey: .credentials)
        let status: String = try container.decode(String.self, forKey: .status)
        let user: User = try container.decode(User.self, forKey: .user)
        self.init(credentials: credentials, status: status, user: user)
    }
}

