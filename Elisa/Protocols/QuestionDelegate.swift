//
//  QuestionDelegate.swift
//  Cards
//
//  Created by Marek Fořt on 8/10/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit 

protocol QuestionDelegate: class {
    var delegateView: UIView {get}
    var slide: Slide? {get}
    var slideStackView: UIStackView {get}
    var checkButton: CheckButton {get}
    func checkButtonTappedWithSuccess(_ successed: Bool)
    func checkButtonTappedWithAnswers(_ answers: [String])
}
