//
//  ViewController.swift
//  Cards
//
//  Created by Marek Fořt on 8/6/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white 
        
        let openButton = UIButton()
        view.addSubview(openButton)
        openButton.translatesAutoresizingMaskIntoConstraints = false
        openButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        openButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        openButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        openButton.setTitle("Start Game", for: .normal)
        openButton.setTitleColor(.black, for: .normal)
        openButton.addTarget(self, action: #selector(openGame), for: .touchUpInside)
    
    }

    @objc private func openGame() {
        let gameViewController = GameViewController()
        present(gameViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

