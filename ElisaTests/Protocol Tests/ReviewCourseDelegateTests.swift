//
//  ReviewCourseDelegateTests.swift
//  ElisaTests
//
//  Created by Marek Fořt on 12/18/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import UIKit

class ReviewCourseDelegateTests: XCTestCase {
    
    let reviewCourseDelegateViewController = ReviewCourseDelegateViewController()
    
    override func setUp() {
        super.setUp()
        
        
        let navigationController = UINavigationController(rootViewController: reviewCourseDelegateViewController)
        reviewCourseDelegateViewController.preloadView()
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        
    }
    
    
    func testShowReviewCourseViewControllerPresentIt() {
        reviewCourseDelegateViewController.showReviewCourseViewController()
        XCTAssertTrue(reviewCourseDelegateViewController.navigationController?.presentedViewController is ReviewCourseViewController)
    }
    
    
}


class ReviewCourseDelegateViewController: UIViewController, ReviewCourseDelegate {    
    var shouldShowAchievementView: Bool = false 
    var reviewCourseViewControllerBeingPresented: Bool = false
    var courseId: Int = 0
    
}
