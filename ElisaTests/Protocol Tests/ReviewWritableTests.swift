//
//  ReviewWritableTests.swift
//  ElisaTests
//
//  Created by Marek Fořt on 12/18/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa

class ReviewWritableTests: XCTestCase {
    
    let initialViewController: UIViewController = UIViewController()
    let reviewWritableViewController: ReviewWritableViewController = ReviewWritableViewController()
    
    override func setUp() {
        super.setUp()
        
        let navigationController = UINavigationController(rootViewController: initialViewController)
        reviewWritableViewController.preloadView()
        UIApplication.shared.keyWindow?.rootViewController = navigationController
        navigationController.present(reviewWritableViewController, animated: false, completion: nil)
    }
    
    override func tearDown() {
        let tabBarController: TabBarController = TabBarController()
        UIApplication.shared.keyWindow?.rootViewController = tabBarController
    }
    
    func testPresentWriteReviewControllerPresentsIt() {
        let starView: StarView = StarView()
        reviewWritableViewController.presentWriteReviewController(with: starView)
        XCTAssertNotEqual(reviewWritableViewController, reviewWritableViewController.navigationController?.topViewController)
    }
    
    
    
    
}

class ReviewWritableViewController: UIViewController, ReviewWritable, ResponseShowable {
    var courseId: Int = 0
    var isResponseFinished: Bool = true
    var responseView: ResponseView?
}
