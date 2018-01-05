//
//  FoundationTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 9/22/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
@testable import Elisa
import Foundation

class FoundationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSettingCredentialsSetCredentials() {
        let userManager = UserManager()
        let userManagerCredentials = userManager.getCredentials()!
        let url = URL(string: "https://private-2ac87a-bitesized.apiary-mock.com/api")
        var urlRequest = URLRequest(url: url!)
        urlRequest.setCredentialsHeader()
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "\(userManagerCredentials.tokenType.capitalized) \(userManagerCredentials.accessToken)")
    }
    
    
}
