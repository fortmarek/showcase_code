//
//  CourseViewModelTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/29/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
import Foundation
@testable import Elisa
import ReactiveSwift

class CourseViewModelTests: XCTestCase {
    
    let courseViewModel = CourseViewModelMock()
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testGetLessonsActionGetsRightInfo() {
        
        //TODO: Repair when time_created is added to the apiary
        
//        let getLessonsExpectation = expectation(description: "Waiting to get lessons")
//
//        courseViewModel.courseDescription.producer.startWithValues { desc in
//            guard desc != "" else {return}
//            XCTAssertEqual(desc, "Api for Bitesized application. Every request (except login/registration) should have Authorization header with access token. Distance is always in kilometers. If user has locale that has mile units, its computed on client")
//        }

        
        
//        courseViewModel.getLessonsAction.apply("id").startWithCompleted {
//            getLessonsExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func testSetLastUpdatedLessonIndex() {
        let courseViewModel = CourseViewModel()
        let lessonOne = Lesson(id: 0, name: "", picture: "", completed: 0.3)
        let lessonCompleted = Lesson(id: 0, name: "", picture: "", completed: 1.0)
        let lessonEmpty = Lesson(id: 0, name: "", picture: "", completed: 0.0)
        let lessons = [lessonOne, lessonCompleted, lessonEmpty, lessonEmpty]
        courseViewModel.setLastUpdatedLessonIndex(lessons: lessons)
        XCTAssertEqual(courseViewModel.lastUnlockedLessonIndex, 2)
    }
    
}


class CourseViewModelMock: CourseViewModel {
    override init() {
        super.init()
        setupBindings() 
        serverPath = "https://private-2ac87a-bitesized.apiary-mock.com/api/"
    }
}
