//
//  DetailUser.swift
//  Cards
//
//  Created by Marek Fořt on 9/7/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation

struct UserStruct {
    let user: DetailUser
}
extension UserStruct: Decodable {
    enum UserStructKeys: String, CodingKey {
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserStructKeys.self)
        let user: DetailUser = try container.decode(DetailUser.self, forKey: .user)
        self.init(user: user)
    }
}

struct DetailUser {
    let id: Int
    let email: String
    let fullname: String
    let points: Int
    let language: String?
    let rank: Int?
    let avatar: String?
    var imageModel: ImageModel
}

extension DetailUser: Decodable {
    enum DetailUserKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case fullname = "fullname"
        case points = "points"
        case language = "language"
        case rank = "rank"
        case avatar = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DetailUserKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let email: String = try container.decode(String.self, forKey: .email)
        let fullname: String = try container.decode(String.self, forKey: .fullname)
        let points: Int = try container.decode(Int.self, forKey: .points)
        let language: String? = try container.decodeIfPresent(String.self, forKey: .language)
        let rank: Int? = try container.decodeIfPresent(Int.self, forKey: .rank)
        let avatar: String? = try container.decodeIfPresent(String.self, forKey: .avatar)
        let imageModel: ImageModel = ImageModel()
        self.init(id: id, email: email, fullname: fullname, points: points, language: language, rank: rank, avatar: avatar, imageModel: imageModel)
        self.imageModel.picture = avatar
    }
}



