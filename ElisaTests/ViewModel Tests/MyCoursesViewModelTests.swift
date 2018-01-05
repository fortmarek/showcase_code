//
//  MyCoursesViewModelTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import ReactiveSwift
import Foundation

class MyCoursesViewModelTests: XCTestCase {
    
    let myCoursesViewModel = MyCoursesViewModel()
    
    let ongoingCoursePreview = CoursePreview(id: 0, name: "", category: CategoryPreview(name: "cat"), completed: 30.0, desc: nil, author: Author(name: "", picture: ""), lastActivity: nil, imageModel: ImageModel())
    let completedCoursePreview = CoursePreview(id: 0, name: "", category: CategoryPreview(name: "cat"), completed: 100.0, desc: nil, author: Author(name: "", picture: ""), lastActivity: nil, imageModel: ImageModel())

    
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testFilteringCompletedCoursesWorks() {
        myCoursesViewModel.courses.value = [completedCoursePreview, ongoingCoursePreview]
        myCoursesViewModel.completedCourses.producer.startWithValues { completedCourses in
            XCTAssertEqual(completedCourses.count, 1)
        }
    }
    
    func testFilteringOngoingCoursesWorks() {
        myCoursesViewModel.courses.value = [ongoingCoursePreview, ongoingCoursePreview, completedCoursePreview]
        myCoursesViewModel.ongoingCourses.producer.startWithValues { ongoingCourses in
            XCTAssertEqual(ongoingCourses.count, 2)
        }
    }
    
    //APIARY: Repair
//    func testFetchingMyCoursesSucceeds() {
//        let getMyCoursesExpectation = expectation(description: "Wait for my courses")
//        let myCoursesViewModel = MyCoursesViewModelMock()
//        myCoursesViewModel.getCoursesAction.apply("profile/courses").start()
//
//        myCoursesViewModel.getCoursesAction.completed.observeValues {
//            getMyCoursesExpectation.fulfill()
//        }
//
//        myCoursesViewModel.getCoursesAction.errors.observeValues { error in
//            XCTFail()
//        }
//
//        waitForExpectations(timeout: 3, handler: nil)
//
//    }
    
}

class MyCoursesViewModelMock: MyCoursesViewModel {
    override init() {
        super.init()
        serverPath = "https://private-2ac87a-bitesized.apiary-mock.com/api/"
    }
}


