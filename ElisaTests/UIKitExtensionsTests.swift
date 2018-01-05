//
//  UIKitExtensionsTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 8/8/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import ReactiveSwift

class UIKitExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testDownloadImageDownloadsImage() {
        let path: String? = "https://cdni.ilikeyou.com/ui_big/1304462.jpg"
        var downloadedImage: UIImage? = nil
        let getImageExpectation = expectation(description: "Wait for image download")
        UIImage.downloadImage(path: path).startWithResult {result in
            guard let image = result.value else {XCTFail(); return}
            downloadedImage = image
            getImageExpectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(downloadedImage)
    }
}
