//
//  AuthenticationAPIService.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import KeychainAccess
import ReactiveSwift
import Result
import FBSDKCoreKit
import FBSDKLoginKit

protocol AuthenticationAPIServicing {
    func login(_ email: String, password: String) -> SignalProducer<AuthenticationStruct, ServerError>
    func signup(fullname: String, email: String, password: String) -> SignalProducer<AuthenticationStruct, ServerError>
    //func refresh(_ token: String) -> SignalProducer<Credentials, NSError>
    //func signWithFacebook(_ token: String) -> SignalProducer<(UserEntity, Credentials), NSError>
}

class AuthenticationAPIService: APIService, AuthenticationAPIServicing {
    
    let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
    
    func signup(fullname: String, email: String, password: String) -> SignalProducer<AuthenticationStruct, ServerError> {
        let subpath = "sign-up?client_id=\(clientId)&client_secret=\(clientSecret)"
        let jsonDictionary: [String: Any] = ["email" : email, "password" : password, "fullname" : fullname]
        return SignalProducer<AuthenticationStruct, ServerError> { [weak self] sink, disposable in
            self?.postCodableData(jsonDictionary: jsonDictionary, subpath: subpath, codableType: AuthenticationStruct.self).startWithResult { result in
                self?.saveUserAndCrendentials(with: result, sink: sink)
            }
        }
    }
    
    func login(_ email: String, password: String) -> SignalProducer<AuthenticationStruct, ServerError> {
        let subpath =  "sign-in?client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=password&username=\(email)&password=\(password)"
        return SignalProducer<AuthenticationStruct, ServerError> { [weak self] sink, disposable in
            self?.getCodableStruct(subpath: subpath, codableType: AuthenticationStruct.self).startWithResult {result in
                self?.saveUserAndCrendentials(with: result, sink: sink)
            }
        }
    }
    
    private func saveUserAndCrendentials(with result: Result<AuthenticationStruct, ServerError>, sink: SignalProducer<AuthenticationStruct, ServerError>.ProducedSignal.Observer) {
        guard let authenticationStruct = result.value else {
            sink.send(error: result.error ?? .defaultError)
            return}
        do {
            try userManager.createUserAndCredentials(authenticationStruct.user, credentials: authenticationStruct.credentials)
            sink.send(value: authenticationStruct)
            sink.sendCompleted()
        }
        catch let error {
            print(error)
            sink.send(error: .defaultError)
        }
    }
    
    func signWithFacebook(_ token: String) -> SignalProducer<AuthenticationStruct, ConnectionError> {
        let subpath =  "sign-in/facebook?client_id=\(clientId)&client_secret=\(clientSecret)"
        let facebookTokenData = ["facebook_token": token]
        
        return SignalProducer<AuthenticationStruct, ConnectionError> { [weak self] sink, disposable in
            
            return self?.postCodableData(jsonDictionary: facebookTokenData, subpath: subpath, codableType: AuthenticationStruct.self).startWithResult { result in
                do {
                    guard let facebookStruct = result.value else {sink.send(error: .DecodeError); return}
                    try self?.userManager.createUserAndCredentials(facebookStruct.user, credentials: facebookStruct.credentials)
                    sink.send(value: facebookStruct)
                    sink.sendCompleted()
                }
                catch let error {
                    print(error)
                    sink.send(error: .DecodeError)
                }
            }
        }
    }
    
    func logout() -> SignalProducer<Status, ConnectionError> {
        let path = serverPath + "sign-out"
        return SignalProducer<Status, ConnectionError> { [weak self] sink, disposable in
            
            self?.getData(path: path).startWithResult { result in
                guard let data = result.value else {return}
                do {
                    let decoder = JSONDecoder()
                    let status = try decoder.decode(Status.self, from: data)
                    try self?.userManager.deleteSavedData()
                    sink.send(value: status)
                    sink.sendCompleted()
                }
                catch let error {
                    print(error)
                    sink.send(error: .DecodeError)
                }
            }
            
        }
    }
    
    
    func sendNotificationToken(_ token: String) -> SignalProducer<Status, ConnectionError> {
        return SignalProducer { [weak self] sink, disposable in
            self?.putCodableData(jsonDictionary: ["gcm_token": token], subpath: "device", codableType: Status.self).startWithResult { result in
                guard let status = result.value else {sink.send(error: .NoDataError); return}
                sink.send(value: status)
                sink.sendCompleted()
            }
        }
    }
    
    
    func refreshToken() -> SignalProducer<Credentials, ConnectionError> {
        
        return SignalProducer<Credentials, ConnectionError> { [weak self] sink, disposable in
            guard let credentials = self?.userManager.getCredentials(),
                let serverPath = self?.serverPath,
                let clientId = self?.clientId,
                let clientSecret = self?.clientSecret
                else {return}
            
            let path = serverPath + "token?client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=refresh_token&refresh_token=\(credentials.refreshToken)"
            
            self?.getData(path: path).startWithResult { result in
                guard let data = result.value else {return}
                do {
                    let decoder = JSONDecoder()
                    let credentials = try decoder.decode(Credentials.self, from: data)
                    try credentials.setInSecureStore()
                    sink.send(value: credentials)
                    sink.sendCompleted()
                }
                catch let error {
                    print(error)
                    sink.send(error: .DecodeError)
                }
            }
            
        }
    }
}

