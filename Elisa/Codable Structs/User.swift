//
//  User.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import CoreData

struct User {
    static var entityName: String = "UserEntity"
    var objectID: NSManagedObjectID?
    
    var fullname: String = ""
    var email: String
    let id: Int
    
    init(email: String, id: Int, objectID: NSManagedObjectID?, fullname: String?, points: Int?, language: String?, rank: Int?, avatar: String?) {
        self.email = email
        self.id = id
        self.objectID = objectID
    }
    
    init(email: String, id: Int, objectID: NSManagedObjectID?, fullname: String?) {
        self.init(email: email, id: id, objectID: objectID, fullname: fullname, points: nil, language: nil, rank: nil, avatar: nil)
    }
}

extension User: Decodable {
    
    enum UserKeys: String, CodingKey {
        case email = "email"
        case id = "id"
        case userId = "user_id"
        case points = "points"
        case language = "language"
        case rank = "rank"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        let email: String = try container.decode(String.self, forKey: .email)
        let finalId: Int
        if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
            finalId = id
        }
        else {
            finalId = try container.decode(Int.self, forKey: .userId)
        }
        let points: Int? = try container.decodeIfPresent(Int.self, forKey: .points)
        let language: String? = try container.decodeIfPresent(String.self, forKey: .language)
        let rank: Int? = try container.decodeIfPresent(Int.self, forKey: .rank)
        let avatar: String? = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.init(email: email, id: finalId, objectID: nil, fullname: nil, points: points, language: language, rank: rank, avatar: avatar)
    }
}

extension User: ManagedDecodable {
    func setValues(_ object: NSManagedObject, context: NSManagedObjectContext) {
        object.setValue(id, forKey: "id")
        object.setValue(email, forKey: "email")
        object.setValue(fullname, forKey: "fullname")
    }
    
    static func managedToEntity(_ managedObject: NSManagedObject?) -> ManagedDecodable? {
        guard let managedObject = managedObject else {return nil}
        let user = User(email: managedObject.value(forKey: "email") as! String, id: managedObject.value(forKey: "id") as! Int, objectID: managedObject.objectID, fullname: managedObject.value(forKey: "fullname") as? String)
        return user
    }
}

