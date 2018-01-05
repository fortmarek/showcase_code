//
//  Course.swift
//  Cards
//
//  Created by Marek Fořt on 8/25/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation

struct CourseStruct {
    let course: Course
    
    init(course: Course) {
        self.course = course
    }
}

extension CourseStruct: Decodable {
    enum CourseStructKeys: String, CodingKey {
        case course = "course"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CourseStructKeys.self)
        let course: Course = try container.decode(Course.self, forKey: .course)
        self.init(course: course)
    }
}

struct Course {
    let id: Int
    let name: String
    let desc: String
    let picture: String
    let author: Author
    let rating: Float
    let lessons: [Lesson]
    let reviews: [Review]
    
    init(id: Int, name: String, desc: String, picture: String, author: Author, rating: Float, lessons: [Lesson], reviews: [Review]) {
        self.id = id
        self.name = name
        self.desc = desc
        self.picture = picture
        self.author = author
        self.rating = rating
        self.lessons = lessons
        self.reviews = reviews
    }
}

extension Course: Decodable {
    enum CourseKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case desc = "desc"
        case picture = "picture"
        case author = "author"
        case rating = "rating"
        case lessons = "lessons"
        case reviews = "reviews"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CourseKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let desc: String = try container.decode(String.self, forKey: .desc)
        let picture: String = try container.decode(String.self, forKey: .picture)
        let author: Author = try container.decode(Author.self, forKey: .author)
        let rating: Float = try container.decode(Float.self, forKey: .rating)
        let lessons: [Lesson] = try container.decode([Lesson].self, forKey: .lessons)
        let reviews: [Review] = try container.decode([Review].self, forKey: .reviews)
        self.init(id: id, name: name, desc: desc, picture: picture, author: author, rating: rating, lessons: lessons, reviews: reviews)
    }
}

struct Lesson {
    let id: Int
    let name: String
    let picture: String
    var completed: Double
    
    init(id: Int, name: String, picture: String, completed: Double) {
        self.id = id
        self.name = name
        self.picture = picture
        self.completed = completed
    }
}

extension Lesson: Decodable {
    
    enum LessonKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture"
        case completed = "completed"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LessonKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let picture: String = try container.decode(String.self, forKey: .picture)
        if let completed: Double = try container.decodeIfPresent(Double.self, forKey: .completed) {
            self.init(id: id, name: name, picture: picture, completed: completed * 0.01)
        }
        else {
            self.init(id: id, name: name, picture: picture, completed: 0.0)
        }
        
    }
}

struct Author: Codable {
    let name: String?
    let picture: String
}




