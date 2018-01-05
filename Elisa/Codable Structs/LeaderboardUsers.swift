//
//  LeaderboardUsers.swift
//  Cards
//
//  Created by Marek Fořt on 9/23/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation

struct Leaderboard {
    let friends: [LeaderboardUser]
    let geoLeaderboard: GeoLeaderboard
}

extension Leaderboard: Decodable {
    enum LeaderboardKeys: String, CodingKey {
        case friends = "users"
        case geo = "geo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderboardKeys.self)
        let friends: [LeaderboardUser] = try container.decode([LeaderboardUser].self, forKey: .friends)
        let geoLeaderboard: GeoLeaderboard = try container.decode(GeoLeaderboard.self, forKey: .geo)
        self.init(friends: friends, geoLeaderboard: geoLeaderboard)
    }
}

struct GeoLeaderboard {
    let title: String
    let geoUsers: [LeaderboardUser]
}

extension GeoLeaderboard: Decodable {
    
    enum GeoLeaderboardKeys: String, CodingKey {
        case title = "title"
        case geoUsers = "users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeoLeaderboardKeys.self)
        let title: String = try container.decode(String.self, forKey: .title)
        let geoUsers: [LeaderboardUser] = try container.decode([LeaderboardUser].self, forKey: .geoUsers)
        self.init(title: title, geoUsers: geoUsers)
    }
}


struct LeaderboardUsers {
    let users: [LeaderboardUser]
    
    init(users: [LeaderboardUser]) {
        self.users = users
    }
}

extension LeaderboardUsers: Decodable {
    enum LeaderboardUsersKeys: String, CodingKey {
        case users = "users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LeaderboardUsersKeys.self)
        let users: [LeaderboardUser] = try container.decode([LeaderboardUser].self, forKey: .users)
        self.init(users: users)
    }
}

struct LeaderboardUser: ImageStructable {
    let id: Int
    let name: String
    let points: Int
    let picture: String
    var imageModel: ImageModel = ImageModel()
    
    init(id: Int, name: String, points: Int, picture: String) {
        self.id = id
        self.name = name
        self.points = points
        self.picture = picture
        self.imageModel.picture = picture
    }
}

extension LeaderboardUser: Decodable {
    enum CoursePreviewKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case points = "points"
        case picture = "picture"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoursePreviewKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let points: Int = try container.decode(Int.self, forKey: .points)
        let picture: String = try container.decode(String.self, forKey: .picture)
        self.init(id: id, name: name, points: points, picture: picture)
    }
}

extension LeaderboardUser: Equatable {
    static func ==(lhs: LeaderboardUser, rhs: LeaderboardUser) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.points == rhs.points
    }
}
