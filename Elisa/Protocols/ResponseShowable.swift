//
//  ResponseShowable.swift
//  Bitesized
//
//  Created by Marek Fořt on 10/21/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit 

protocol ResponseShowable: class {
    var isResponseFinished: Bool {get set}
    var responseView: ResponseView? {get set}
    func showResponse(succeeded: Bool, title: String, asset: ImageAsset)
}

extension ResponseShowable where Self: UIViewController {
    
    func showResponse(succeeded: Bool, title: String, asset: ImageAsset) {
        setResponseInitialPosition()
        guard isResponseFinished else {return}
        isResponseFinished = false
        responseView?.backgroundColor = succeeded ? .greenSuccess : .salmon
        responseView?.responseLabel.text = title
        responseView?.responseImageView.image = UIImage(asset: asset)
        animateResponseView(reversed: false)
    }
    
    private func animateResponseView(reversed: Bool) {
        let dampingRatio: CGFloat = reversed ? 1.0 : 0.5
        let responsePropertyAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: dampingRatio, animations: nil)
        responsePropertyAnimator.addAnimations {
            let yMargin: CGFloat = self.navigationController == nil ? UIApplication.shared.statusBarFrame.height : 0
            self.responseView?.frame.origin.y += reversed ? -(70 + yMargin) : 70
        }
        
        let finishAnimationCompletion = {
            self.isResponseFinished = true
            self.responseView?.removeFromSuperview()
        }
        
        let completion = reversed ? finishAnimationCompletion : {self.animateResponseView(reversed: true)}
        
        responsePropertyAnimator.addCompletion { _ in
            completion()
        }
        
        
        responsePropertyAnimator.startAnimation(afterDelay: reversed ? 1.5 : 0.0)
    }
    
    func setResponseInitialPosition() {
        guard isResponseFinished else {return}
        let width: CGFloat = view.frame.width < 400 ? view.frame.width - 40 : 360
        let responseView = ResponseView(frame: CGRect(x: view.frame.width / 2 - width / 2, y: -140, width: width, height: 140))
        view.addSubview(responseView)
        view.layoutIfNeeded()
        let navigationControllerOffset = (navigationController?.navigationBar.frame.height ?? 0) + (navigationController?.navigationBar.frame.origin.y ?? 0)
        let yMargin: CGFloat
        if navigationController != nil {
            yMargin = (navigationController?.isKind(of: SwipeViewController.self) ?? false) ? 0 : navigationControllerOffset
        }
        else {
            yMargin = UIApplication.shared.statusBarFrame.height
        }
        responseView.frame.origin.y = -140 + yMargin
        self.responseView = responseView
    }
}
