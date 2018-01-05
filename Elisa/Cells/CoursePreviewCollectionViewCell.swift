//
//  HomeCoursePreviewCollectionViewCell.swift
//  Cards
//
//  Created by Marek Fořt on 9/16/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit

class CoursePreviewCollectionViewCell: UICollectionViewCell, CourseCollectionViewCellPreviewable {
    
    var courseId: Int = 0 
    let courseImageView = UIImageView()
    let courseCategoryLabel = UILabel()
    let courseTitleLabel = UILabel()
    let courseStackView = UIStackView()
    
    var courseStackViewHeightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        createCoursePreview()
    }
    
    func createCoursePreview() {

        
        courseStackView.axis = .vertical
        courseStackView.alignment = .leading
        courseStackView.spacing = 18
        courseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(courseStackView)
        courseStackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        courseStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pinToView(courseStackView)

        
        courseStackView.addArrangedSubview(courseImageView)
        setCourseImageView()
        
        
        let coursefeaturedInfoStackView = UIStackView()
        coursefeaturedInfoStackView.axis = .vertical
        coursefeaturedInfoStackView.alignment = .leading
        coursefeaturedInfoStackView.distribution = .equalSpacing
        courseStackView.addArrangedSubview(coursefeaturedInfoStackView)
        coursefeaturedInfoStackView.widthAnchor.constraint(equalTo: courseImageView.widthAnchor).isActive = true
        setCourseInfo(stackView: coursefeaturedInfoStackView)
        
        
    }
    
    private func setCourseInfo(stackView: UIStackView) {
        
        courseTitleLabel.numberOfLines = 2
        courseTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.heavy)
        stackView.addArrangedSubview(courseTitleLabel)
        
        courseCategoryLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        stackView.addArrangedSubview(courseCategoryLabel)
        courseCategoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    private func setCourseImageView() {
        
        courseImageView.backgroundColor = .paleGrey
        courseImageView.heightAnchor.constraint(equalToConstant: 147).isActive = true
        courseStackViewHeightAnchor?.constant += 147
        courseImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        courseImageView.layer.cornerRadius = 12
        courseImageView.clipsToBounds = true
        courseImageView.contentMode = .scaleAspectFill
        
        guard !AppDelegate.isiPad else {return}
        let shadowLayer = CALayer()
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowColor = UIColor.stormyBlue.cgColor
        courseImageView.addShadowLayer(shadowLayer)
         
    }
    
    required init(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
