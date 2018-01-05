//
//  Credentials.swift
//  Cards
//
//  Created by Marek Fořt on 8/12/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import KeychainAccess

//struct Credentials: CreateableSecureStorable, GenericPasswordSecureStorable {
struct Credentials {
    
    static let keychainAccount = "cards"
    
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let scope: String
    let refreshToken: String
    
    init(accessToken: String, expiresIn: Int, tokenType: String, scope: String, refreshToken: String) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.tokenType = tokenType
        self.scope = scope
        self.refreshToken = refreshToken
    }
    
    init?(data: [String: Any]?) {
        if let data = data, let accessToken = data["accessToken"] as? String, let refreshToken = data["refreshToken"] as? String, let expiresIn = data["expiresIn"] as? Int, let scope = data["scope"] as? String, let tokenType = data["tokenType"] as? String {
            self.init(accessToken: accessToken, expiresIn: expiresIn, tokenType: tokenType, scope: scope, refreshToken: refreshToken)
        } else {
            return nil
        }
    }
    
    var data: [String: Any] {
        return ["accessToken": accessToken, "expiresIn": expiresIn, "tokenType": tokenType, "scope": scope, "refreshToken": refreshToken]
    }
    
    
    func setInSecureStore() throws {
        let keychain = Keychain(service: Credentials.keychainAccount)
        for pair in data {
            try keychain.set("\(pair.value)", key: pair.key)
        }
    }
    

    static func readFromSecureStore() throws -> Credentials? {
        let keychain = Keychain(service: Credentials.keychainAccount)
        guard let accessToken = try keychain.get("accessToken"), let expiresIn = try keychain.get("expiresIn"), let scope = try keychain.getString("scope"), let tokenType = try keychain.getString("tokenType"), let refreshToken = try keychain.getString("refreshToken") else {throw ConnectionError.DecodeError}
        let credentials = Credentials(accessToken: accessToken, expiresIn: Int(expiresIn)!, tokenType: tokenType, scope: scope, refreshToken: refreshToken)
        return credentials
    }

    
    static func deleteFromSecureStore() throws {
        let keychain = Keychain(service: Credentials.keychainAccount)
        try keychain.removeAll()
    }
    
    
}

extension Credentials: Decodable {
    
    enum CredentialsKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope = "scope"
        case refreshToken = "refresh_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CredentialsKeys.self)
        let accessToken: String = try container.decode(String.self, forKey: .accessToken)
        let expiresIn: Int = try container.decode(Int.self, forKey: .expiresIn)
        let tokenType: String = try container.decode(String.self, forKey: .tokenType)
        let scope: String = try container.decode(String.self, forKey: .scope)
        let refreshToken: String = try container.decode(String.self, forKey: .refreshToken)
        self.init(accessToken: accessToken, expiresIn: expiresIn, tokenType: tokenType, scope: scope, refreshToken: refreshToken)
    }
}

extension Credentials: Equatable {
    static func ==(lhs: Credentials, rhs: Credentials) -> Bool {
        return lhs.accessToken == rhs.accessToken && lhs.expiresIn == rhs.expiresIn && lhs.tokenType == rhs.tokenType && lhs.scope == rhs.scope && lhs.refreshToken == rhs.refreshToken
    }

}
