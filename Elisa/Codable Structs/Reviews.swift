//
//  Reviews.swift
//  Cards
//
//  Created by Marek Fořt on 9/13/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation

struct Reviews {
    let reviews: [Review]
}

extension Reviews: Decodable {
    enum ReviewsKeys: String, CodingKey {
        case reviews = "reviews"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewsKeys.self)
        let reviews: [Review] = try container.decode([Review].self, forKey: .reviews)
        self.init(reviews: reviews)
    }
}

struct Review {
    let name: String
    let rating: Double
    let text: String
    let dateCreated: Date
    let imageModel: ImageModel
}

extension Review: Decodable {
    enum ReviewKeys: String, CodingKey {
        case name = "name"
        case picture = "picture"
        case rating = "rating"
        case text = "text"
        case timeCreated = "time_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        let picture: String = try container.decode(String.self, forKey: .picture)
        let rating: Double = try container.decode(Double.self, forKey: .rating)
        let text: String = try container.decode(String.self, forKey: .text)
        let timeCreated: String = try container.decode(String.self, forKey: .timeCreated)
        let dateCreated: Date = timeCreated.stringToDate()
        let imageModel: ImageModel = ImageModel()
        self.init(name: name, rating: rating, text: text, dateCreated: dateCreated, imageModel: imageModel)
        imageModel.picture = picture
    }
}
