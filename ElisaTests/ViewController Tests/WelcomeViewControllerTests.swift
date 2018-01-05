//
//  WelcomeViewControllerTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 8/12/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

@testable import Elisa
import XCTest

class WelcomeViewControllerTests: XCTestCase {
    
    let welcomeViewController = WelcomeViewController()
    let mockUpWelcomeViewController = MockUpWelcomeViewController()
    
    override func setUp() {
        super.setUp()
     
        welcomeViewController.preloadView()
        mockUpWelcomeViewController.preloadView()
    }
    
    func testLogInButtonTappedTriggersLogInButtonTappedFunction() {
        mockUpWelcomeViewController.logInButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockUpWelcomeViewController.logInButtonTappedTriggered)
    }
    
    func testTappingLogInFacebookButtonTriggersLogInFacebookButtonTapped() {
        mockUpWelcomeViewController.logInFacebookButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockUpWelcomeViewController.logInFacebookButtonTappedTriggered)
    }
    
    func testTappingSignUpButtonTriggersSignUpButtonTapped() {
        mockUpWelcomeViewController.signUpButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockUpWelcomeViewController.signUpButtonTappedTriggered)
    }
    
}


class MockUpWelcomeViewController: WelcomeViewController {
    var logInButtonTappedTriggered: Bool = false
    var logInFacebookButtonTappedTriggered: Bool = false
    var signUpButtonTappedTriggered: Bool = false
    
    override func logInButtonTapped() {
        logInButtonTappedTriggered = true
    }
    
    override func logInFacebookButtonTapped() {
        logInFacebookButtonTappedTriggered = true
    }
    
    override func signUpButtonTapped() {
        signUpButtonTappedTriggered = true
    }
    
    
}








