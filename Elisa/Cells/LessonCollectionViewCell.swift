//
//  LessonCollectionViewCell.swift
//  Cards
//
//  Created by Marek Fořt on 8/26/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit



class LessonCollectionViewCell: UICollectionViewCell, GridCollectionViewCellDelegate, ProgressDelegate {
    
    
    var delegateView: UIView = UIView()
    let chapterLabel = UILabel()
    let chapterNameLabel = UILabel()
    let shadowProgressBar = UIView()
    let greenProgressBar = UIView()
    var greenProgressBarWidthAnchor: NSLayoutConstraint?
    let backgroundLockedView: UIView = UIView()
    
    var lesson: Lesson? {
        didSet {
            guard let lesson = self.lesson else {return}
            chapterNameLabel.text = lesson.name
            updateProgressBar(shouldActivate: false, completedFraction: lesson.completed)
        }
    }
    
    func setLocked() {
        isUserInteractionEnabled = false
        backgroundLockedView.isHidden = false
        chapterLabel.textColor = .coolGrey
        chapterNameLabel.textColor = .coolGrey
    }
    
    func setUnlocked() {
        isUserInteractionEnabled = true
        backgroundLockedView.removeFromSuperview()
        chapterLabel.textColor = .defaultTextColor
        chapterNameLabel.textColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundLockedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundLockedView)
        backgroundLockedView.pinToView(self)
        backgroundLockedView.layer.cornerRadius = 12
        backgroundLockedView.backgroundColor = UIColor.coolGrey.withAlphaComponent(0.12)
        backgroundLockedView.isHidden = true
        
        let lessonStackView = UIStackView()
        lessonStackView.axis = .vertical
        lessonStackView.alignment = .leading
        lessonStackView.spacing = 3
        lessonStackView.translatesAutoresizingMaskIntoConstraints = false
        lessonStackView.isLayoutMarginsRelativeArrangement = true
        lessonStackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20)
        addSubview(lessonStackView)
        lessonStackView.pinToViewHorizontally(self)
        lessonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        
        chapterLabel.font = AppDelegate.isScreenSmall ? UIFont.systemFont(ofSize: 17, weight: .semibold) : UIFont.systemFont(ofSize: 20, weight: .heavy)
        chapterLabel.textColor = .defaultTextColor
        lessonStackView.addArrangedSubview(chapterLabel)
        
        
        chapterNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        chapterNameLabel.textColor = UIColor.black.withAlphaComponent(0.6)
        chapterNameLabel.numberOfLines = 2
        lessonStackView.addArrangedSubview(chapterNameLabel)
        
        
        setGridCollectionViewCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
