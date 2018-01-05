//
//  CourseViewController.swift
//  Cards
//
//  Created by Marek Fořt on 8/25/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

class CourseViewController: UIViewController, LessonProgressUpdatable, DismissDelegate, ResponseShowable, ProgressDelegate, CourseProgressDelegate, ReviewWritable, ReviewCourseDelegate {
    
    var shadowProgressBar: UIView = UIView()
    var greenProgressBar: UIView = UIView()
    var greenProgressBarWidthAnchor: NSLayoutConstraint?
    
    
    weak var updateCoursesDelegate: UpdateDelegate?
    var shouldUpdateCourses: Bool = false
    
    let courseProgressStackView = UIStackView()
    let lessonsHeaderLabel = UILabel()
    let courseNameLabel = UILabel()
    let descriptionLabel = UILabel()
    let authorImageView = UIImageView()
    let authorNameLabel = UILabel()
    let ratingLabel = UILabel()
    let lessonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var lessonsCollectionViewHeightAnchor: NSLayoutConstraint?
    var lessonCellWidth: CGFloat = 0
    var reviewCourseViewControllerBeingPresented: Bool = false
    var shouldShowAchievementView: Bool = false
    let starsView = TapStarView()
    var starsViewModel: StarViewModeling?
    var responseView: ResponseView?
    var isResponseFinished: Bool = true
    let noReviewsLabel = UILabel()
    let reviewsStackView = UIStackView()
    let reviewsCollectionViewContoller = ReviewsCollectionViewController()
    var reviewsCollectionView: UICollectionView?
    var reviewsCollectionViewHeightAnchor: NSLayoutConstraint?
    
    var lessons: [Lesson] = []
    
    var viewModel = CourseViewModel()

    var courseId: Int = 0
    
    //LessonProgressUpdatable
    var lastSelectedCell: ProgressDelegate?
    var progressConstraints: [NSLayoutConstraint?] = []
    var lessonProgressUpdatable: LessonProgressUpdatable?
    
    override func viewDidAppear(_ animated: Bool) {
        
        if shouldShowAchievementView {
            showAchievementView()
        }
        
        updateCourses()
        
        navigationController?.isNavigationBarHidden = false
        viewModel.getNewBadges().start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showReviewCourseViewController()
        
        let shareBarButtonItem = UIBarButtonItem.init(image: UIImage(asset: Asset.share), style: .plain, target: self, action: #selector(shareCouseButtonTapped))
        shareBarButtonItem.image = UIImage(asset: Asset.share)
        navigationItem.rightBarButtonItem = shareBarButtonItem

        updateCoursesDelegate = tabBarController?.viewControllers?[1] as? UpdateDelegate
        
        definesPresentationContext = true
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        view.backgroundColor = .white
        
        let xEdgeInset: CGFloat = AppDelegate.isiPad ? 40 : 20
        
        let numberOfItemsInRow = AppDelegate.isiPad ? 4 : 2
        lessonCellWidth = UICollectionViewCell.getCellWidth(xEdgeInset: xEdgeInset, minInterimSpacing: 20, numberOfItemsInRow: numberOfItemsInRow)
        
        let courseScrollView = UIScrollView()
        courseScrollView.showsHorizontalScrollIndicator = false
        courseScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        courseScrollView.contentInset = UIEdgeInsets(top: 10, left: xEdgeInset, bottom: 0, right: xEdgeInset)
        view.addSubview(courseScrollView)
        courseScrollView.pinToView(view)
        
        let courseStackView = UIStackView()
        courseStackView.axis = .vertical
        courseStackView.spacing = 20
        courseStackView.translatesAutoresizingMaskIntoConstraints = false
        courseScrollView.addSubview(courseStackView)
        courseStackView.pinToView(courseScrollView)
        courseStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -(xEdgeInset * 2)).isActive = true
        
        let basicInfoStackView = UIStackView()
        basicInfoStackView.spacing = 8
        basicInfoStackView.alignment = .leading
        basicInfoStackView.axis = .vertical
        courseStackView.addArrangedSubview(basicInfoStackView)
        
        courseNameLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        courseNameLabel.textColor = .defaultTextColor
        courseNameLabel.numberOfLines = 0
        basicInfoStackView.addArrangedSubview(courseNameLabel)
        
        let moreInfoStackView = UIStackView()
        moreInfoStackView.distribution = .equalSpacing
        moreInfoStackView.axis = .horizontal
        basicInfoStackView.addArrangedSubview(moreInfoStackView)
        
        let authorInfoStackView = UIStackView()
        authorInfoStackView.axis = .horizontal
        authorInfoStackView.alignment = .center
        authorInfoStackView.spacing = 10
        moreInfoStackView.addArrangedSubview(authorInfoStackView)
        
        authorNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        authorNameLabel.textColor = .cornflower

        authorImageView.backgroundColor = .coolGrey
        authorImageView.clipsToBounds = true
        authorInfoStackView.addArrangedSubview(authorImageView)
        let authorNameLabelHeight = authorNameLabel.font.getHeight() + 10
        authorImageView.setHeightAndWidthAnchorToConstant(authorNameLabelHeight)
        authorImageView.layer.cornerRadius = authorNameLabelHeight / 2
        
        authorInfoStackView.addArrangedSubview(authorNameLabel)
        
        let ratingStackView = UIStackView()
        ratingStackView.axis = .horizontal
        ratingStackView.alignment = .center
        ratingStackView.spacing = 3
        moreInfoStackView.addArrangedSubview(ratingStackView)
        ratingStackView.trailingAnchor.constraint(equalTo: courseStackView.trailingAnchor).isActive = true
        
        ratingLabel.text = "0"
        ratingLabel.textColor = .squash
        ratingLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        let starImageView = UIImageView()
        starImageView.image = UIImage(asset: Asset.star)
        ratingStackView.addArrangedSubview(starImageView)
        starImageView.setHeightAndWidthAnchorToConstant(15)
        
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.numberOfLines = 0
        courseStackView.addArrangedSubview(descriptionLabel)
        
        
        courseProgressStackView.axis = .vertical
        courseProgressStackView.alignment = .leading
        courseProgressStackView.spacing = 12
        courseStackView.addArrangedSubview(courseProgressStackView)
        
        let courseProgressHeaderLabel = UILabel()
        courseProgressHeaderLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        courseProgressHeaderLabel.textColor = .defaultTextColor
        courseProgressHeaderLabel.text = L10n.Course.courseProgress
        courseProgressStackView.addArrangedSubview(courseProgressHeaderLabel)
        courseProgressHeaderLabel.pinToViewHorizontally(courseProgressStackView)
        
        let progressBarContainer = UIView()
        courseProgressStackView.addArrangedSubview(progressBarContainer)
        progressBarContainer.pinToViewHorizontally(courseScrollView)
        progressBarContainer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        addProgressBar(to: progressBarContainer, barHeight: 10, inset: 0)
        updateProgressBar(shouldActivate: true, completedFraction: 0)
        
        
        
        let lessonsStackView = UIStackView()
        lessonsStackView.spacing = 15
        lessonsStackView.axis = .vertical
        lessonsStackView.alignment = .leading
        courseStackView.addArrangedSubview(lessonsStackView)
        
        
        lessonsHeaderLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        lessonsHeaderLabel.textColor = .defaultTextColor
        lessonsHeaderLabel.text = L10n.Course.lessons
        lessonsStackView.addArrangedSubview(lessonsHeaderLabel)
        lessonsHeaderLabel.pinToViewHorizontally(lessonsStackView)
        
        lessonsCollectionView.clipsToBounds = false
        lessonsCollectionView.delegate = self
        lessonsCollectionView.dataSource = self
        lessonsCollectionView.backgroundColor = .white
        lessonsStackView.addArrangedSubview(lessonsCollectionView)
        lessonsCollectionView.widthAnchor.constraint(equalTo: lessonsStackView.widthAnchor).isActive = true
        
        lessonsCollectionViewHeightAnchor = lessonsCollectionView.heightAnchor.constraint(equalToConstant: 0)
        lessonsCollectionViewHeightAnchor?.isActive = true
        lessonsCollectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: "lessonCell")
        
        
        reviewsStackView.axis = .vertical
        reviewsStackView.alignment = .leading
        reviewsStackView.spacing = 15
        courseStackView.addArrangedSubview(reviewsStackView)
        reviewsStackView.layoutMargins.bottom = 20
        reviewsStackView.isLayoutMarginsRelativeArrangement = true
        
        let reviewsHeaderLabel = UILabel()
        reviewsHeaderLabel.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight.heavy)
        reviewsHeaderLabel.textColor = .defaultTextColor
        reviewsHeaderLabel.text = L10n.Course.reviews
        reviewsStackView.addArrangedSubview(reviewsHeaderLabel)
        reviewsHeaderLabel.pinToViewHorizontally(reviewsStackView)
        
        
        noReviewsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        noReviewsLabel.textColor = .coolGrey
        noReviewsLabel.text = L10n.Course.noReviews
        noReviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewsStackView.addArrangedSubview(noReviewsLabel)
        
        let addReviewStackView = UIStackView()
        addReviewStackView.spacing = 10
        addReviewStackView.alignment = .leading
        addReviewStackView.axis = .vertical
        reviewsStackView.addArrangedSubview(addReviewStackView)

        
        
        starsView.starsStackView.starViewModel = viewModel
        starsView.starsStackView.courseId = courseId
        starsView.starsStackView.responseDelegate = self
        starsView.starsStackView.spacing = view.frame.width >= 370 ? 13 : 7
        addReviewStackView.addArrangedSubview(starsView)
        starsView.leadingAnchor.constraint(equalTo: reviewsStackView.leadingAnchor).isActive = true
        starsView.trailingAnchor.constraint(equalTo: reviewsStackView.trailingAnchor).isActive = true
        starsViewModel = starsView.starsStackView.starViewModel
        
        let writeReviewStackView = UIStackView()
        writeReviewStackView.axis = .horizontal
        writeReviewStackView.alignment = .bottom
        writeReviewStackView.spacing = 12
        addReviewStackView.addArrangedSubview(writeReviewStackView)
        writeReviewStackView.isLayoutMarginsRelativeArrangement = true
        writeReviewStackView.layoutMargins.left = 5
        writeReviewStackView.layoutMargins.bottom = 3
        
        let writeReviewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(writeReviewTapped))
        writeReviewStackView.addGestureRecognizer(writeReviewTapGestureRecognizer)
        
        let writeReviewImageView = UIImageView()
        writeReviewImageView.image = UIImage(asset: Asset.writeReviewIcon)
        writeReviewImageView.contentMode = .scaleAspectFit
        writeReviewStackView.addArrangedSubview(writeReviewImageView)
        writeReviewImageView.widthAnchor.constraint(equalToConstant: 19).isActive = true
        
        let writeReviewLabel = UILabel()
        writeReviewLabel.text = L10n.Course.writeReview
        writeReviewLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        writeReviewLabel.textColor = .cornflower
        writeReviewStackView.addArrangedSubview(writeReviewLabel)
        
        
        reviewsCollectionViewContoller.currentWidth = view.frame.width - 2 * xEdgeInset
        reviewsCollectionViewContoller.minimumLineSpacing = 25
        let reviewsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reviewsCollectionViewContoller)
        reviewsCollectionView.clipsToBounds = false
        reviewsCollectionView.backgroundColor = .white
        reviewsCollectionView.dataSource = reviewsCollectionViewContoller
        reviewsCollectionView.delegate = reviewsCollectionViewContoller
        reviewsCollectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "reviewCell")
        reviewsStackView.addArrangedSubview(reviewsCollectionView)
        reviewsCollectionView.widthAnchor.constraint(equalTo: reviewsStackView.widthAnchor).isActive = true
        reviewsCollectionViewHeightAnchor = reviewsCollectionView.heightAnchor.constraint(equalToConstant: 0)
        reviewsCollectionViewHeightAnchor?.isActive = true
        self.reviewsCollectionView = reviewsCollectionView
        
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.getLessonsAction.apply(courseId).start()
        
        viewModel.courseProgress.producer.observe(on: UIScheduler()).startWithValues { [weak self] courseProgress in
            self?.view.layoutIfNeeded()
            self?.updateProgressBar(shouldActivate: true, completedFraction: courseProgress)
            UIView.animate(withDuration: 1.0, animations: {
                self?.view.layoutIfNeeded()
            })
        }
        descriptionLabel.reactive.text <~ viewModel.courseDescription
        viewModel.authorPicture.producer.observe(on: UIScheduler()).startWithValues { [weak self] image in
            self?.authorImageView.setImage(image, animated: true)
        }
        authorNameLabel.reactive.text <~ viewModel.authorName
        viewModel.rating.producer.observe(on: UIScheduler()).startWithValues { [weak self] rating in
            self?.ratingLabel.text = rating > 0 ? "\(rating)" : "\(0)"
        }
        
        courseProgressStackView.reactive.isHidden <~ viewModel.lessons.map {$0.isEmpty}
        lessonsHeaderLabel.reactive.isHidden <~ viewModel.lessons.map {$0.isEmpty}
        reviewsStackView.reactive.isHidden <~ viewModel.lessons.map {$0.isEmpty}
        
        viewModel.lessons.producer.observe(on: UIScheduler()).startWithValues { [weak self] lessons in
            self?.reloadLessonCollectionView(lessons: lessons)
        }
        
        viewModel.reviews.producer.observe(on: UIScheduler()).startWithValues { [weak self] reviews in
            self?.reviewsCollectionViewContoller.reviews = reviews
            self?.reviewsCollectionView?.reloadData()
            self?.view.layoutIfNeeded()
        }
        
        noReviewsLabel.reactive.isHidden <~ viewModel.reviews.producer.map { $0.isNotEmpty }
        
        viewModel.badges.producer.observe(on: UIScheduler()).startWithValues {[weak self] badges in
            guard badges.isNotEmpty else {return}
            self?.showAchievementView()
        }
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setLessonCollectionViewHeight(lessons: lessons, size: size, animated: true)
        reviewsCollectionViewContoller.currentWidth = size.width - 80
        reviewsCollectionViewContoller.invalidateLayout()
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func setLessonCollectionViewHeight(lessons: [Lesson], size: CGSize, animated: Bool) {
        let numberOfItemsInRow: CGFloat = ((size.width - 40) / lessonCellWidth).rounded(.down)
        let numberOfRows: CGFloat = (CGFloat(lessons.count) / numberOfItemsInRow).rounded(.up)
        if numberOfRows > 0 {
            lessonsCollectionViewHeightAnchor?.constant = CGFloat(numberOfRows * (110 + 20) - 20)
        }
        guard animated else {return}
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func reloadLessonCollectionView(lessons: [Lesson]) {
        self.lessons = lessons
        setLessonCollectionViewHeight(lessons: lessons, size: view.frame.size, animated: false)
        progressConstraints = []
        lessonsCollectionView.reloadData()
        activateConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        if let reviewsCollectionViewHeight = reviewsCollectionView?.contentSize.height {
            reviewsCollectionViewHeightAnchor?.constant = reviewsCollectionViewHeight
        }
    }
    
    func updateCourses() {
        if shouldUpdateCourses {
            updateCoursesDelegate?.updateValues()
            shouldUpdateCourses = false
        }
    }

    @objc func shareCouseButtonTapped() {
        share(title: L10n.Course.shareCourse(courseNameLabel.text ?? ""), barButtonItem: navigationItem.rightBarButtonItem, completion: nil)
    }
    
    @objc func writeReviewTapped() {
        presentWriteReviewController(with: starsView.starsStackView)
    }
    
    func showAchievementView() {
        //Check if ReviewCourseViewController is not presented
        guard reviewCourseViewControllerBeingPresented == false else {shouldShowAchievementView = true; return}
        shouldShowAchievementView = false
        let achievementViewController = AchievementViewController()
        achievementViewController.badges = viewModel.badges.value
        achievementViewController.initialTabBarController = tabBarController
        achievementViewController.initialNavigationController = navigationController
        navigationController?.present(achievementViewController, animated: true, completion: nil)
    }
    
}

extension CourseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameViewController = GameViewController()
        gameViewController.initialLessonProgress = lessons[indexPath.row].completed
        let lesson = lessons[indexPath.row]
        gameViewController.id = lesson.id
        gameViewController.lessonName = lesson.name 
        gameViewController.indexInArray = indexPath.row
        gameViewController.lessonProgressUpdatable = self
        gameViewController.courseProgressDelegate = self
        gameViewController.reviewCourseDelegate = self
        gameViewController.isLastLesson = indexPath.row == lessons.count - 1
        gameViewController.initialController = navigationController
        
        navigationController?.present(gameViewController, animated: true, completion: nil)
        let lastSelectedCell = collectionView.cellForItem(at: indexPath) as? LessonCollectionViewCell
        lastSelectedCell?.backgroundLockedView.isHidden = false
        self.lastSelectedCell = lastSelectedCell
        shouldUpdateCourses = true
    }
}

extension CourseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lessonCell: LessonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "lessonCell", for: indexPath) as! LessonCollectionViewCell
        lessonCell.lesson = lessons[indexPath.row]
        lessonCell.chapterLabel.text = L10n.Course.chapter(indexPath.row + 1)
        progressConstraints.append(lessonCell.greenProgressBarWidthAnchor)
        
        guard indexPath.row != 0 else {lessonCell.setUnlocked(); return lessonCell}
        
        let shouldCellBeLocked = indexPath.row > viewModel.lastUnlockedLessonIndex
        shouldCellBeLocked ? lessonCell.setLocked() : lessonCell.setUnlocked()
        
        
        return lessonCell
    }
    
    func unlockCell(index: Int) {
        let cellToUnlock = lessonsCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? LessonCollectionViewCell
        cellToUnlock?.setUnlocked()
    }
    
}

extension CourseViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 110
        return CGSize(width: lessonCellWidth, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

