//
//  Slides.swift
//  Cards
//
//  Created by Marek Fořt on 8/7/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation


struct Slides {
    let slides: [Slide]
    let lastViewedSlideId: Int?
    
    init(slides: [Slide], lastViewedSlideId: Int?) {
        self.slides = slides
        self.lastViewedSlideId = lastViewedSlideId
    }
}

struct Slide {
    let id: Int
    let title: String?
    let text: String?
    let picture: String?
    var question: Question?
    
    init(id: Int, title: String?, text: String?, picture: String?, question: Question?) {
        self.id = id
        self.title = title
        self.text = text
        self.picture = picture
        self.question = question
    }
}

enum QuestionType: String {
    case select = "select"
    case write = "write"
}

struct Question {
    let type: QuestionType
    let options: [Option]?
    let answer: Any
    var didSucceed: Bool = false
    
    
    init(type: QuestionType, options: [Option]?, answer: Any) {
        self.type = type
        self.options = options
        self.answer = answer
    }
}

struct Option {
    let id: Int
    let value: String
    
    init(id: Int, value: String) {
        self.id = id
        self.value = value
    }
}

extension Option: Equatable {
    static func ==(lhs: Option, rhs: Option) -> Bool {
        return lhs.id == rhs.id && lhs.value == rhs.value
    }
}

extension Slides: Decodable {
    
    enum SlidesKeys: String, CodingKey {
        case slides = "slides"
        case lastViewedSlideId = "last_viewed_slide_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SlidesKeys.self)
        let slides: [Slide] = try container.decode([Slide].self, forKey: .slides)
        let lastViewedSlideId: Int? = try container.decodeIfPresent(Int.self, forKey: .lastViewedSlideId)
        self.init(slides: slides, lastViewedSlideId: lastViewedSlideId)
        
    }
}

extension Slide: Decodable {
    
    enum SlideKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case text = "text"
        case picture = "picture"
        case question = "question"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SlideKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let title: String? = try container.decodeIfPresent(String.self, forKey: .title)
        let text: String? = try container.decodeIfPresent(String.self, forKey: .text)
        let picture: String? = try container.decodeIfPresent(String.self, forKey: .picture)
        let question: Question? = try container.decodeIfPresent(Question.self, forKey: .question)
        self.init(id: id, title: title, text: text, picture: picture, question: question)
    }
}

extension Slide: Equatable {
    static func ==(lhs: Slide, rhs: Slide) -> Bool {
        return lhs.id == rhs.id && lhs.text == rhs.text && lhs.picture == rhs.picture
    }
}

extension Question: Decodable {
    
    enum QuestionKeys: String, CodingKey {
        case type = "type"
        case options = "options"
        case answer = "answer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionKeys.self)
        let type: String = try container.decode(String.self, forKey: .type)
        let options: [Option]? = try container.decodeIfPresent([Option].self, forKey: .options)
        guard let typeEnum: QuestionType = QuestionType(rawValue: type) else {throw ConnectionError.DecodeError}
        if  typeEnum == .select {
            let answer: [Int] = try container.decode([Int].self, forKey: .answer)
            self.init(type: typeEnum, options: options, answer: answer)
        }
        else {
            let answerArray: [String] = try container.decode([String].self, forKey: .answer)
            self.init(type: typeEnum, options: options, answer: answerArray[0])
        }
        
    }
}

extension Option: Decodable {
    
    enum OptionKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OptionKeys.self)
        let id: Int = try container.decode(Int.self, forKey: .id)
        let value: String = try container.decode(String.self, forKey: .value)
        self.init(id: id, value: value)
        
    }
}

