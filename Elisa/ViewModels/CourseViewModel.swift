
//
//  CourseViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 8/25/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result



protocol CourseViewModeling {
    var getLessonsAction: Action<Any, Course, ConnectionError> {get}
    var courseName: MutableProperty<String> {get}
    var courseDescription: MutableProperty<String> {get}
    var courseProgress: MutableProperty<Double> {get}
    var course: MutableProperty<Course?> {get set}
    var authorPicture: MutableProperty<UIImage?> {get}
    var authorName: MutableProperty<String?> {get}
    var rating: MutableProperty<Float> {get}
    var lessons: MutableProperty<[Lesson]> {get}
    var reviews: MutableProperty<[Review]> {get}
    var lastUnlockedLessonIndex: Int {get}
}

class CourseViewModel: APIService, CourseViewModeling, ReviewModeling, StarViewModeling, BadgesViewModeling {
    var course: MutableProperty<Course?> = MutableProperty(nil)
    var courseName: MutableProperty<String> = MutableProperty("")
    var courseDescription: MutableProperty<String> = MutableProperty("")
    var courseProgress: MutableProperty<Double> = MutableProperty(0.0)
    var authorPicture: MutableProperty<UIImage?> = MutableProperty(nil)
    var authorName: MutableProperty<String?> = MutableProperty(nil)
    var rating: MutableProperty<Float> = MutableProperty(0.0)
    var lessons: MutableProperty<[Lesson]> = MutableProperty([])
    var reviews: MutableProperty<[Review]> = MutableProperty([])
    var badges: MutableProperty<[Badge]> = MutableProperty([])
    var lastUnlockedLessonIndex: Int = 0
    
    override init() {
        super.init()
        setupBindings()
    }
    
    lazy var getLessonsAction: Action<Any, Course, ConnectionError> = {
        Action<Any, Course, ConnectionError> {[weak self] id in
            return SignalProducer { [weak self] sink, disposable in
                guard let serverPath = self?.serverPath else {return}
                self?.getData(path: serverPath + "courses/\(id)").startWithResult { result in
                    guard let courseData = result.value else {return}
                    do {
                        let decoder = JSONDecoder()
                        let course: Course = try decoder.decode(CourseStruct.self, from: courseData).course
                        self?.setLastUpdatedLessonIndex(lessons: course.lessons)
                        self?.course.value = course
                        sink.send(value: course)
                        sink.sendCompleted()
                    }
                    catch let error {
                        print(error)
                        sink.send(error: .DecodeError)
                    }
                }
            }
        }
    }()
    
    func setLastUpdatedLessonIndex(lessons: [Lesson]) {
        for (index, lesson) in lessons.enumerated() {
            guard lesson.completed != 0.0 else {continue}
            lastUnlockedLessonIndex = lesson.completed == 1.0 ? index + 1 : index
        }
    }
    
    func setupBindings() {
        let courseProducer = course.producer.skipNil()
        courseName <~ courseProducer.map {$0.name}
        courseDescription <~ courseProducer.map {$0.desc}
        courseProgress <~ lessons.map {[weak self] lessons in
            return self?.getCourseProgress(lessons: lessons) ?? 0.0
        }
        authorName <~ courseProducer.map {$0.author.name}
        courseProducer.observe(on: UIScheduler()).startWithValues { course in
            course.author.picture.getImage().producer.startWithValues { [weak self] image in
                self?.authorPicture.value = image
            }
        }
        rating <~ courseProducer.map {$0.rating}
        lessons <~ courseProducer.map {$0.lessons}
        reviews <~ courseProducer.map {$0.reviews}
        
        
        
        setupBadgesBindings() 
    }
    
    private func getCourseProgress(lessons: [Lesson]) -> Double {
        guard lessons.count > 0 else {return 0.0}
        var combinedProgress: Double = 0.0
        lessons.forEach {combinedProgress += $0.completed}
        let courseProgress: Double = combinedProgress / Double(lessons.count)
        return courseProgress
    }
}
