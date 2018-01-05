//
//  Lessons.swift
//  Cards
//
//  Created by Marek Fořt on 8/13/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

protocol ImageStructable {
    var imageModel: ImageModel {get}
}

struct Courses {
    let courses: [CoursePreview]
    
    init(courses: [CoursePreview]) {
        self.courses = courses
    }
}

extension Courses: Decodable {
    enum CoursesKeys: String, CodingKey {
        case courses = "courses"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoursesKeys.self)
        let courses: [CoursePreview] = try container.decode([CoursePreview].self, forKey: .courses)
        self.init(courses: courses)
    }
}

struct CoursePreview: ImageStructable {
    
    let id: Int
    let name: String?
    let category: CategoryPreview?
    let completed: Double?
    let desc: String?
    let author: Author
    let lastActivity: Date?
    var imageModel: ImageModel
}

extension CoursePreview: Decodable {
    
    enum CoursePreviewKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case category = "cat"
        case picture = "picture"
        case completed = "completed"
        case desc = "desc"
        case author = "author"
        case lastActivity = "last_activity"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoursePreviewKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String? = try container.decodeIfPresent(String.self, forKey: .name)
        let category: CategoryPreview? = try container.decodeIfPresent(CategoryPreview.self, forKey: .category)
        let picture: String? = try container.decodeIfPresent(String.self, forKey: .picture)
        let completed: Double? = try container.decodeIfPresent(Double.self, forKey: .completed)
        let desc: String? = try container.decodeIfPresent(String.self, forKey: .desc)
        let author: Author = try container.decode(Author.self, forKey: .author)
        let lastActivityString: String? = try container.decodeIfPresent(String.self, forKey: .lastActivity)
        let lastActivity = lastActivityString?.stringToDate()
        let imageModel = ImageModel()
        self.init(id: id, name: name, category: category, completed: completed, desc: desc, author: author, lastActivity: lastActivity, imageModel: imageModel)
        self.imageModel.picture = picture
    }
}

extension CoursePreview: Equatable {
    
    static func ==(lhs: CoursePreview, rhs: CoursePreview) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.category?.name == rhs.category?.name && lhs.completed == rhs.completed && lhs.desc == rhs.desc
    }
}


struct CategoryPreview: Codable {
    let name: String?
    //let id: Int?
}

