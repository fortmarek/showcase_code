//
//  CategoryCourseCollectionViewCell.swift
//  Cards
//
//  Created by Marek Fořt on 8/28/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit


class CategoryCourseCollectionViewCell: UICollectionViewCell, CourseCollectionViewCellPreviewable {
    
    var courseId: Int = 0
    var courseTitleLabel: UILabel = UILabel()
    let courseImageView: UIImageView = UIImageView()
    let courseDescriptionLabel = UILabel()
    let authorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let courseStackView = UIStackView()
        courseStackView.axis = .horizontal
        courseStackView.alignment = .top
        courseStackView.spacing = 19
        courseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(courseStackView)
        courseStackView.pinToViewVertically(self)
        courseStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        courseStackView.widthAnchor.constraint(equalTo: widthAnchor).activate(with: .defaultLow)
        courseStackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true 
        courseStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true
        
        courseImageView.contentMode = .scaleAspectFill
        courseImageView.layer.cornerRadius = 10
        courseImageView.clipsToBounds = true
        courseStackView.addArrangedSubview(courseImageView)
        courseImageView.setHeightAndWidthAnchorToConstant(125)
        courseImageView.backgroundColor = .paleGrey
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 4
        infoStackView.alignment = .leading
        courseStackView.addArrangedSubview(infoStackView)
        
        courseTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        courseTitleLabel.textAlignment = .left
        courseTitleLabel.textColor = .defaultTextColor
        courseTitleLabel.numberOfLines = 2
        infoStackView.addArrangedSubview(courseTitleLabel)
        
        courseDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        courseDescriptionLabel.textColor = .gray
        courseDescriptionLabel.numberOfLines = 3
        infoStackView.addArrangedSubview(courseDescriptionLabel)
        
        authorLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        authorLabel.textColor = .cornflower
        infoStackView.addArrangedSubview(authorLabel)
        authorLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true 
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
