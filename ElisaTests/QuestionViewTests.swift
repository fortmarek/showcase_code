//
//  QuestionViewTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/26/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Cards
import UIKit

class QuestionViewTests: XCTestCase {
    
    let questionView = QuestionView()
    
    let question = Question(type: .select, options: [Option(id: 0, value: "K"), Option(id: 0, value: "Hello")], answer: 0)
    
    override func setUp() {
        super.setUp()
        
        questionView.slide = Slide(id: 0, title: "", text: "", picture: "", question: question)
        questionView.setQuestionView()
        
    }
    
    
}
