//
//  WelcomeViewController.swift
//  Cards
//
//  Created by Marek Fořt on 8/10/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit
import ReactiveSwift

class WelcomeViewController: UIViewController, LoadingDelegate {
    
    let welcomeViewModel = WelcomeViewModel()
    
    let signUpButton = UIButton()
    let logInFacebookButton = UIButton()
    let logInButton = UIButton()

    var loadingImageView: LoadingImageView = LoadingImageView()
    var isExecuting: MutableProperty<Bool> = MutableProperty(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        view.backgroundColor = .white
        
        let welcomeStackView = UIStackView()
        welcomeStackView.axis = .vertical
        welcomeStackView.alignment = .center
        welcomeStackView.spacing = 20
        welcomeStackView.translatesAutoresizingMaskIntoConstraints = false 
        view.addSubview(welcomeStackView)
        welcomeStackView.topAnchor.constraint(greaterThanOrEqualTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        welcomeStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        welcomeStackView.pinToViewHorizontally(view)
        welcomeStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        let welcomeArtworkImageView = UIImageView()
        welcomeArtworkImageView.image = UIImage(asset: Asset.welcomeArtwork)
        welcomeArtworkImageView.contentMode = .scaleAspectFit
        welcomeStackView.addArrangedSubview(welcomeArtworkImageView)
        welcomeArtworkImageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40).isActive = true
        
        let welcomeTextStackView = UIStackView()
        welcomeTextStackView.axis = .vertical
        welcomeTextStackView.alignment = .center
        welcomeTextStackView.spacing = 12
        welcomeStackView.addArrangedSubview(welcomeTextStackView)
        
        let welcomeLabel = UILabel()
        welcomeLabel.numberOfLines = 0
        welcomeLabel.text = L10n.Welcome.welcome
        welcomeLabel.textColor = .defaultTextColor
        welcomeLabel.font = UIFont.headerStyleFont()
        welcomeTextStackView.addArrangedSubview(welcomeLabel)
        
        welcomeLabel.setAnchorsToSizeToFit()

        let welcomeSubtitleLabel = UILabel()
        welcomeSubtitleLabel.numberOfLines = 0
        welcomeSubtitleLabel.textAlignment = .center
        welcomeSubtitleLabel.text = L10n.Welcome.title
        welcomeSubtitleLabel.font = UIFont.normalTextStyleFont()
        welcomeSubtitleLabel.textColor = .defaultTextColor
        welcomeTextStackView.addArrangedSubview(welcomeSubtitleLabel)
        welcomeSubtitleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40).isActive = true
        view.layoutIfNeeded()
        welcomeSubtitleLabel.setAnchorsToSizeToFit()


        let signUpButtonsStackView = UIStackView()
        signUpButtonsStackView.axis = .vertical
        signUpButtonsStackView.alignment = .center
        signUpButtonsStackView.spacing = 19
        welcomeStackView.addArrangedSubview(signUpButtonsStackView)
        signUpButtonsStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomLayoutGuide.topAnchor, constant: -40).isActive = true
        
        signUpButton.setTitle(L10n.Welcome.signUp, for: .normal)
        signUpButton.titleLabel?.font = UIFont.buttonStyleFont()
        signUpButton.backgroundColor = .cornflower
        signUpButton.layer.cornerRadius = 27
        signUpButtonsStackView.addArrangedSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)


        
        
        logInFacebookButton.setTitle(L10n.Welcome.logInFacebook, for: .normal)
        logInFacebookButton.titleLabel?.font = UIFont.buttonStyleFont()
        logInFacebookButton.backgroundColor = .facebookBlue
        logInFacebookButton.layer.cornerRadius = 27
        signUpButtonsStackView.addArrangedSubview(logInFacebookButton)
        logInFacebookButton.sizeToFit()
        logInFacebookButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        logInFacebookButton.widthAnchor.constraint(equalToConstant: logInFacebookButton.frame.width + 80).isActive = true
        logInFacebookButton.addTarget(self, action: #selector(logInFacebookButtonTapped), for: .touchUpInside)
        signUpButton.widthAnchor.constraint(equalToConstant: logInFacebookButton.frame.width + 80).isActive = true
        
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.cornflower.cgColor
        shadowLayer.shadowRadius = 5
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowOffset = CGSize(width: 0, height: 4)
        
        signUpButton.addShadowLayer(shadowLayer)
        shadowLayer.shadowColor = UIColor.facebookBlue.cgColor
        logInFacebookButton.addShadowLayer(shadowLayer)

        

        let logInButtonAttributes: [NSAttributedStringKey : Any] = [
            .font : UIFont.normalTextStyleFont(),
            .foregroundColor: UIColor.darkGray,
            .underlineStyle : 1]
        let logInAttributedString = NSAttributedString(string: L10n.Welcome.logIn, attributes: logInButtonAttributes)
        logInButton.setAttributedTitle(logInAttributedString, for: .normal)
        logInButton.layer.cornerRadius = 27
        signUpButtonsStackView.addArrangedSubview(logInButton)
        logInButton.setAnchorsToSizeToFit()
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    
        setupBindings()
        

        
    }
    
    private func setupBindings() {
        welcomeViewModel.loginWithFacebook.events.observe(on: UIScheduler()).observeValues { result in
            guard result.value != nil else {return}
            let window = UIApplication.shared.keyWindow
            window?.rootViewController = TabBarController()
            window?.makeKeyAndVisible()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func signUpButtonTapped() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func logInButtonTapped() {
        navigationController?.pushViewController(LogInViewController(), animated: true)
    }
    
    @objc func logInFacebookButtonTapped() {
        addRotatingLoadingImageView()
        welcomeViewModel.loginWithFacebook.apply(self).start()
    }
    


}
