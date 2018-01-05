//
//  Badges.swift
//  Cards
//
//  Created by Marek Fořt on 9/7/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit

struct BadgesStruct {
    let achievements: [Badge]
    
    init(achievements: [Badge]) {
        self.achievements = achievements
    }
}

extension BadgesStruct: Decodable {
    enum BadgeStructKeys: String, CodingKey {
        case achievements = "achievements"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BadgeStructKeys.self)
        let achievements: [Badge] = try container.decode([Badge].self, forKey: .achievements)
        self.init(achievements: achievements)
    }
}



struct Badge {
    let id: Int
    let name: String
    let picture: String
    let desc: String
    var imageModel = ImageModel()
    
    init(id: Int, name: String, picture: String, desc: String) {
        self.id = id
        self.name = name
        self.picture = picture
        self.desc = desc
    }
}

extension Badge: Decodable {
    
    enum BadgeKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture"
        case desc = "desc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BadgeKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let picture: String = try container.decode(String.self, forKey: .picture)
        let desc: String = try container.decode(String.self, forKey: .desc)
        self.init(id: id, name: name, picture: picture, desc: desc)
        self.imageModel.picture = picture
    }
}

extension Badge: Equatable {
    
    static func ==(lhs: Badge, rhs: Badge) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.picture == rhs.picture && lhs.desc == rhs.desc
    }
}
