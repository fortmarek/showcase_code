//
//  SignUpViewControllerTests.swift
//  CardsTests
//
//  Created by Marek Fořt on 8/23/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import XCTest
import ReactiveSwift
@testable import Elisa

class SignUpViewControllerTests: XCTestCase {
    
    let signUpViewController: SignUpViewController = SignUpViewController()
    
    override func setUp() {
        super.setUp()
        
        signUpViewController.preloadView()
    }
    
    func testTappingJoinButtonTriggersJoinButtonTapped() {
        let signUpViewControllerMock: SignUpViewControllerMock = SignUpViewControllerMock()
        signUpViewControllerMock.preloadView()
        
        signUpViewControllerMock.joinButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(signUpViewControllerMock.joinButtonWasTapped)
        
    }
    
//    func testJoinButtonTappedTriggersSignUpIfFielddFilled() {
//        signUpViewController.viewModel = SignUpViewModelMock()
//        signUpViewController.joinButton.isSelected = true
//        signUpViewController.mailTextField.text = "JJ"
//        signUpViewController.passwordTextField.text = "KK"
//        signUpViewController.joinButton.sendActions(for: .touchUpInside)
//        guard let signUpViewControllerViewModelMock = signUpViewController.viewModel as? SignUpViewModelMock else {XCTFail(); return}
//        XCTAssertTrue(signUpViewControllerViewModelMock.signUpCalled)
//    }
    
}

class SignUpViewControllerMock: SignUpViewController {
    
    var joinButtonWasTapped: Bool = false

    override func joinButtonTapped() {
        joinButtonWasTapped = true
    }
}

//class SignUpViewModelMock: SignUpViewModel {
//    
//    var signUpCalled: Bool = false
//    
//    
//    override lazy var signUp: Action<(String, String, String), AuthenticationStruct, ConnectionError> = {
//        Action<(String, String, String), AuthenticationStruct, ConnectionError> { [unowned self] fullname, email, password in
//            self.signUpCalled = true
//            return self.authenticationAPIService.signup(fullname: fullname, email: email, password: password)
//        }
//    }()
//}

