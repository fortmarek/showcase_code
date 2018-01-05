//
//  CourseViewControllerPreviewable.swift
//  Cards
//
//  Created by Marek Fořt on 9/30/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit

protocol CourseViewControllerPreviewable {
}

extension CourseViewControllerPreviewable where Self: UIViewController {
    
    func previewCourseViewController(collectionViews: [UICollectionView?], location: CGPoint) -> UIViewController? {
        
        let collectionViewsBeingTouched = collectionViews.filter{$0?.isLocationInside(location: location, mainSuperview: self.view) ?? false}
        guard let collectionViewBeingTouched = collectionViewsBeingTouched.first else {return nil}
        
        let convertedLocation = view.convert(location, to: collectionViewBeingTouched)
        
        guard let indexPath = collectionViewBeingTouched?.indexPathForItem(at: convertedLocation),
            let previewCell = collectionViewBeingTouched?.cellForItem(at: indexPath) as? CourseCollectionViewCellPreviewable
            else {return nil}
        
        let courseViewController = CourseViewController()
        courseViewController.courseId = previewCell.courseId
        courseViewController.courseNameLabel.text = previewCell.courseTitleLabel.text
        courseViewController.preferredContentSize = CGSize(width: 0, height: view.frame.height - 100)
        
        return courseViewController
    }
}

