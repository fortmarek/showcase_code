//
//  OptionsViewTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/26/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Cards
import UIKit

class OptionsViewTests: XCTestCase {
    
    let question = Question(type: .select, options: [Option(id: 0, value: "K"), Option(id: 0, value: "Hello")], answer: 0)
    
    let questionDelegateMock = OptionsViewDelegateMock()
    
    override func setUp() {
        super.setUp()
        let slide = Slide(id: 0, title: nil, text: nil, picture: nil, question: question)
        questionDelegateMock.slide = slide
    }
    
}


class OptionsViewDelegateMock: QuestionDelegate {
    
    var slide: Slide?
    var slideStackView: UIStackView = UIStackView()
    var checkButton: ButtonColorChangeable = ButtonColorChangeable(title: "Button", normalColor: .white, selectedColor: .white)
    
    func checkButtonTappedWithSuccess(_ successed: Bool) {
        
    }
    
    func checkButtonTappedWithAnswers(_ answers: [String]) {
        
    }
    
    
}
