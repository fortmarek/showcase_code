//
//  Categories.swift
//  Cards
//
//  Created by Marek Fořt on 8/28/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
struct Categories {
    let categories: [CategoryBasic]
    
    init(categories: [CategoryBasic]) {
        self.categories = categories
    }
}

extension Categories: Decodable {
    enum CategoriesKeys: String, CodingKey {
        case categories = "categories"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoriesKeys.self)
        let categories: [CategoryBasic] = try container.decode([CategoryBasic].self, forKey: .categories)
        self.init(categories: categories)
    }
}

struct CategoryBasic: ImageStructable {
    let id: Int
    let name: String
    let picture: String
    var imageModel: ImageModel = ImageModel()
    
    
    init(id: Int, name: String, picture: String) {
        self.id = id
        self.name = name
        self.picture = picture
    }
}

extension CategoryBasic: Decodable {
    enum CategoryBasicKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryBasicKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let picture: String = try container.decode(String.self, forKey: .picture)
        self.init(id: id, name: name, picture: picture)
        self.imageModel.picture = picture 
    }
}
