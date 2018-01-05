//
//  HomeCoursePreviewsCollectionViewDelegate.swift
//  Cards
//
//  Created by Marek Fořt on 9/20/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift




class HomeCoursePreviewsCollectionViewDelegate: UICollectionViewFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching, ImagePrefetchable {

    var shouldHideCategoryLabel: Bool = false
    var previews: [CoursePreview] = []
    var controller: UINavigationController?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coursePreview = previews[indexPath.row]
        let courseViewController = CourseViewController()
        courseViewController.courseId = coursePreview.id
        courseViewController.courseNameLabel.text = coursePreview.name
        controller?.pushViewController(courseViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let previewCell: CoursePreviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCourseCell", for: indexPath) as! CoursePreviewCollectionViewCell
        let coursePreview = previews[indexPath.row]
        previewCell.courseId = coursePreview.id
        previewCell.courseCategoryLabel.text = shouldHideCategoryLabel ? "" : coursePreview.category?.name?.capitalized
        previewCell.courseTitleLabel.text = coursePreview.name
        
        previewCell.courseImageView.bind(with: previews[indexPath.row].imageModel)
        
        return previewCell
    }
    
    func prefetchPreviewsAt(_ indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageModel = previews[indexPath.row].imageModel
            imageModel.setPreviewImage(path: imageModel.picture)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        prefetchPreviewsAt(indexPaths)
    }
}
