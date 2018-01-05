//
//  ReviewCollectionViewCellTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/14/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa

class ReviewCollectionViewCellTests: XCTestCase {
    
    let reviewCollectionViewCell = ReviewCollectionViewCell(frame: .zero)
    
    override func setUp() {
        super.setUp()
        
        
    }
    
    
    func testAddingStarsAddsRightStars() {
        reviewCollectionViewCell.addStars(rating: 3.55)
        let secondStarImageView = reviewCollectionViewCell.starsStackView.subviews[1] as! UIImageView
        let thirdStarImageView = reviewCollectionViewCell.starsStackView.subviews[2] as! UIImageView
        let fourthStarImageView = reviewCollectionViewCell.starsStackView.subviews[3] as! UIImageView
        XCTAssertEqual(secondStarImageView.image, UIImage(asset: Asset.fullStar))
        XCTAssertEqual(thirdStarImageView.image, UIImage(asset: Asset.halfStar))
        XCTAssertEqual(fourthStarImageView.image, UIImage(asset: Asset.emptyStar))
    }
    
}
