//
//  HomeViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 8/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol HomeViewModeling {
    var lessonPreviews: MutableProperty<Courses?> {get}
    func getLessonPreviews(subpath: String) -> SignalProducer<Courses, ConnectionError>
    func getCategories() -> SignalProducer<[CategoryBasic], ConnectionError>
    var categories: MutableProperty<[CategoryBasic]> {get}
}

class HomeViewModel: APIService, HomeViewModeling, BadgesViewModeling {
    var lessonPreviews: MutableProperty<Courses?> = MutableProperty(nil)
    var categories: MutableProperty<[CategoryBasic]> = MutableProperty([])
    var badges: MutableProperty<[Badge]> = MutableProperty([])
    
    override init() {
        super.init()
        setupBindings()
    }
    
    func getLessonPreviews(subpath: String) -> SignalProducer<Courses, ConnectionError> {
        return SignalProducer { [weak self] sink, disposable in
            guard let serverPath = self?.serverPath else {return}
            self?.getData(path: serverPath + subpath).startWithResult { result in
                guard let homeData = result.value else {return}
                do {
                    let decoder = JSONDecoder()
                    let lessons: Courses = try decoder.decode(Courses.self, from: homeData)
                    self?.lessonPreviews.value = lessons
                    sink.send(value: lessons)
                    sink.sendCompleted()
                }
                catch let error {
                    print(error)
                    sink.send(error: .DecodeError)
                }
            }
        }
    }
    
    func getCategories() -> SignalProducer<[CategoryBasic], ConnectionError> {
        return SignalProducer { [weak self] sink, disposable in
            guard let serverPath = self?.serverPath else {return}
            self?.getData(path: serverPath + "categories").startWithResult { [weak self] result in
                guard let categoriesData = result.value else {return}
                do {
                    let decoder = JSONDecoder()
                    let categories: Categories = try decoder.decode(Categories.self, from: categoriesData)
                    self?.categories.value = categories.categories
                    sink.send(value: categories.categories)
                    sink.sendCompleted()
                }
                catch let error {
                    print(error)
                    sink.send(error: .DecodeError)
                }
            }
        }
    }
    
    private func setupBindings() {
        setupBadgesBindings()
    }
}
