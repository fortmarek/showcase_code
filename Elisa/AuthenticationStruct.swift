//
//  SignUpStruct.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation

enum Status: String {
    
    case success = "success"
    
    var rawValue: String {return self.rawValue}

    init(rawValueInit: String) throws {
        self.init(rawValue: rawValueInit)!
        switch rawValue {
            case "success": self = .success
            default: throw ConnectionError.DecodeError
        }
    }
}

extension Status: Decodable {
    enum StatusKeys: String, CodingKey {
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatusKeys.self)
        let statusString: String = try container.decode(String.self, forKey: .status)
        self.init(rawValue: statusString)!
    }
}

struct AuthenticationStruct {
    let credentials: Credentials
    let status: Status
    let user: User
    
    init(credentials: Credentials, status: Status, user: User) {
        self.credentials = credentials
        self.status = status
        self.user = user
    }
}

extension AuthenticationStruct: Decodable {
    enum AuthenticationStructKeys: String, CodingKey {
        case credentials = "credentials"
        case status = "status"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AuthenticationStructKeys.self)
        let statusString: String = try container.decode(String.self, forKey: .status)
        let credentials: Credentials = try container.decode(Credentials.self, forKey: .credentials)
        guard let status = Status(rawValue: statusString) else {throw ConnectionError.DecodeError}
        let user: User = try container.decode(User.self, forKey: .user)
        self.init(credentials: credentials, status: status, user: user)
    }
}

