//
//  WriteReviewViewController.swift
//  Cards
//
//  Created by Marek Fořt on 9/28/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit
import ReactiveSwift

class WriteReviewViewController: UIViewController, Alertable, AlertDelegate {
    
    weak var courseViewStarView: StarView?
    weak var responseDelegate: ResponseShowable?
    let writeReviewModel = WriteReviewModel()
    let writeReviewTextView = UITextView()
    let starView = TapStarView()
    
    var alertDelegate: AlertDelegate?
    
    
    var courseId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertDelegate = self
        
        title = L10n.Course.review
        
        view.backgroundColor = .white

        let barButtonItemTextAttributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.cornflower, .font: UIFont.systemFont(ofSize: 17, weight: .medium)]
        
        let cancelBarButtonItem = UIBarButtonItem(title: L10n.General.cancel, style: .plain, target: self, action: #selector(cancelBarButtonTapped))
        cancelBarButtonItem.setTitleTextAttributes(barButtonItemTextAttributes, for: .normal)
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let sendBarButtonItem = UIBarButtonItem(title: L10n.General.send, style: .plain, target: self, action: #selector(sendBarButtonTapped))
        sendBarButtonItem.setTitleTextAttributes(barButtonItemTextAttributes, for: .normal)
        navigationItem.rightBarButtonItem = sendBarButtonItem
        
        let writeReviewStackView = UIStackView()
        writeReviewStackView.axis = .vertical
        writeReviewStackView.spacing = 17
        writeReviewStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(writeReviewStackView)
        writeReviewStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        writeReviewStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        
        starView.starsStackView.spacing = view.frame.width >= 370 ? 13 : 7
        writeReviewStackView.addArrangedSubview(starView)
        starView.widthAnchor.constraint(equalTo: writeReviewStackView.widthAnchor).isActive = true
        
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.defaultTextColor.withAlphaComponent(0.1)
        writeReviewStackView.addArrangedSubview(separatorView)
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separatorView.pinToViewHorizontally(view)
        
        writeReviewTextView.textColor = .coolGrey
        writeReviewTextView.text = L10n.Course.writeReview
        writeReviewTextView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        writeReviewTextView.delegate = self
        writeReviewTextView.textContainerInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        writeReviewStackView.addArrangedSubview(writeReviewTextView)
        writeReviewTextView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func sendBarButtonTapped() {

        guard writeReviewTextView.text != L10n.Course.writeReview, starView.starsStackView.numberOfSelectedStars > 0 else {displayNotAllInfoAlert(); return}
        
        let responseDelegate = self.responseDelegate
        view.endEditing(true)
        writeReviewModel.sendWrittenReview.apply((starView.starsStackView.numberOfSelectedStars, writeReviewTextView.text, courseId)).producer.observe(on: UIScheduler()).startWithResult { result in
            if result.value == nil {
                responseDelegate?.showResponse(succeeded: false, title: L10n.Course.reviewFailed, asset: Asset.error)
            }
            else {
                responseDelegate?.showResponse(succeeded: true, title: L10n.Course.reviewSucceeded, asset: Asset.checkmark)
            }
        }
        courseViewStarView?.changeRateStarsAccordingToIndex(starView.starsStackView.numberOfSelectedStars)
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func cancelBarButtonTapped() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    private func displayNotAllInfoAlert() {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        displayAlert(title: L10n.Course.reviewFailed, message: L10n.Course.notEnoughInfo, actions: [okAction])
    }
    
    private func dismissSelf() {
        
    }

}


extension WriteReviewViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .coolGrey else {return}
        textView.text = ""
        textView.textColor = .defaultTextColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView.text.isEmpty else {return}
        textView.text = L10n.Course.writeReview
        textView.textColor = .coolGrey
    }
}
