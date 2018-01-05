//
//  ReviewsCollectionViewController.swift
//  Cards
//
//  Created by Marek Fořt on 9/18/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit

class ReviewsCollectionViewController: UICollectionViewFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var reviews: [Review] = []
    var currentWidth: CGFloat = 0
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reviewCell: ReviewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCollectionViewCell
        let review = reviews[indexPath.row]
        reviewCell.reviewLabel.text = review.text
        reviewCell.nameLabel.text = review.name
        reviewCell.reviewerImageView.bind(with: review.imageModel, animated: true, defaultImage: UIImage(asset: Asset.profileDefault))
        reviewCell.dateLabel.text = review.dateCreated.getDaysAgo()
        reviewCell.addStars(rating: review.rating)
        
        //reviewCell.reviewStackView.widthAnchor.constraint(equalToConstant: currentSize.width - 40).isActive = true
        
        return reviewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let reviewLabel = UILabel()
        reviewLabel.numberOfLines = 0
        reviewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        reviewLabel.text = reviews[indexPath.row].text
        reviewLabel.frame.size.width = currentWidth
        reviewLabel.sizeToFit()
        let fixedHeight: CGFloat = reviewLabel.frame.height > 0 ? 165 : 155
        return CGSize(width: currentWidth, height: reviewLabel.frame.height + fixedHeight)
    }
}
