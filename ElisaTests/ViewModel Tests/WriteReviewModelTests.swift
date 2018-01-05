//
//  WriteReviewModelTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/28/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import ReactiveSwift


class WriteReviewModelTests: XCTestCase {
    
    let writeReviewMock = WriteReviewModelMock()
    
    override func setUp() {
        super.setUp()
    }
    
    func testPostingReviewResponse() {
        let postExpectation = expectation(description: "Wait for response of review post")
        writeReviewMock.sendWrittenReview.apply((1, "review", 1)).startWithCompleted {
            postExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}

class WriteReviewModelMock: WriteReviewModel {
    override init() {
        super.init()
        serverPath = "https://private-2ac87a-bitesized.apiary-mock.com/api/"
    }
}

