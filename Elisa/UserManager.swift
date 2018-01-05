//
//  UserManager.swift
//  Cards
//
//  Created by Marek Fořt on 8/23/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import CoreData
import UIKit

protocol UserManaging {
    func isLoggedIn() -> Bool
    func createUserAndCredentials(_ user: User, credentials: Credentials) throws
}

class UserManager: UserManaging {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    lazy var user: User? = {
        let managedObjectContext = self.context
        let users = User.query(User.entityName, context: managedObjectContext, predicate: nil)
        guard let user = users.first as? User else {return nil}
        return user
    }()
    
    
    func getCredentials() -> Credentials? {
        do {
            let credentials = try Credentials.readFromSecureStore()
            //print(credentials)
            return credentials
        }
        catch let error {
            print(error)
            return nil
        }
    }
    
    func isLoggedIn() -> Bool {
        let apiService = AuthenticationAPIService()
        if getCredentials() != nil {
            apiService.refreshToken().start()
        }
        
        return getCredentials() != nil && user != nil
    }
    
    func createUser(_ user: User) {
        if self.user != nil {
            user.resetDataForEntity(User.entityName, context: context)
        }
        self.user = user.createNewManaged(user, context: context)
    }
    
    func createUserAndCredentials(_ user: User, credentials: Credentials) throws {
        if getCredentials() == nil {
            try Credentials.deleteFromSecureStore()
        }
        try credentials.setInSecureStore()
        createUser(user)
    }
    
    func deleteSavedData() throws {
        try Credentials.deleteFromSecureStore()
        self.user?.resetDataForEntity(User.entityName, context: context)
        self.user = nil
    }
    
//    func saveCredentials(_ credentials: Credentials) -> LocksmithError {
//
//        do {
//            try credentials.createInSecureStore()
//        }
//        catch let error {
//            print(error)
//        }
//    }
}
