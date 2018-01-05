//
//  ReviewCourseDelegate.swift
//  Elisa
//
//  Created by Marek Fořt on 12/18/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit

protocol ReviewCourseDelegate: class {
    var shouldShowAchievementView: Bool {get}
    var reviewCourseViewControllerBeingPresented: Bool {get set}
    var courseId: Int {get}
    func showReviewCourseViewController()
}

extension ReviewCourseDelegate where Self: UIViewController {
    func showReviewCourseViewController() {
        let reviewCourseViewController = ReviewCourseViewController()
        reviewCourseViewController.initialTabBarController = tabBarController
        reviewCourseViewController.initialNavigationController = navigationController
        reviewCourseViewController.courseId = courseId
        reviewCourseViewController.reviewCourseDelegate = self
        reviewCourseViewControllerBeingPresented = true 
        navigationController?.present(reviewCourseViewController, animated: true, completion: nil)
    }
}
