//
//  ReviewWritable.swift
//  Elisa
//
//  Created by Marek Fořt on 12/17/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit

protocol ReviewWritable {
    var courseId: Int {get}
    func presentWriteReviewController(with starsView: StarView)
}

extension ReviewWritable where Self: UIViewController, Self: ResponseShowable {
    func presentWriteReviewController(with starsView: StarView) {
        let writeReviewController = WriteReviewViewController()
        let starsStackView = writeReviewController.starView.starsStackView
        starsStackView.changeRateStarsAccordingToIndex(starsView.numberOfSelectedStars)
        writeReviewController.courseId = courseId
        writeReviewController.responseDelegate = self
        writeReviewController.courseViewStarView = starsView
        let writeReviewNavigationController = UINavigationController(rootViewController: writeReviewController)
        present(writeReviewNavigationController, animated: true, completion: nil)
    }
}
