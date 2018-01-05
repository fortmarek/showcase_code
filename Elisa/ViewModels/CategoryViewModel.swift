//
//  CategoryViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 8/28/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol CategoryViewModeling: CoursesViewModeling {
}

class CategoryViewModel: APIService, CategoryViewModeling {
    
    var courses: MutableProperty<[CoursePreview]> = MutableProperty([])
    
    override init() {
        super.init()
        setupBindings()
    }
    
    lazy var getCoursesAction: Action<String, [CoursePreview], ConnectionError> = {
        Action<String, [CoursePreview], ConnectionError> {[unowned self] subpath in
            return self.getCourses(subpath: subpath)
        }
    }()
    
    
    private func setupBindings() {

    }
    
}
