//
//  ProgressDelegate.swift
//  Elisa
//
//  Created by Marek Fořt on 12/3/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import UIKit

protocol ProgressDelegate: class {
    var shadowProgressBar: UIView {get}
    var greenProgressBar: UIView {get}
    var greenProgressBarWidthAnchor: NSLayoutConstraint? {get set}
}

extension ProgressDelegate {
    
    func updateProgressBar(shouldActivate: Bool, completedFraction: Double) {
        greenProgressBarWidthAnchor?.isActive = false
        greenProgressBarWidthAnchor = greenProgressBar.widthAnchor.constraint(equalTo: shadowProgressBar.widthAnchor, multiplier: CGFloat(completedFraction))
        guard shouldActivate else {return}
        greenProgressBarWidthAnchor?.isActive = true
    }
    
    func addProgressBar(to view: UIView, barHeight: CGFloat, inset: CGFloat) {
        shadowProgressBar.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        shadowProgressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shadowProgressBar)
        shadowProgressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset).isActive = true
        shadowProgressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset).isActive = true
        shadowProgressBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        shadowProgressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset).isActive = true
        shadowProgressBar.layer.cornerRadius = barHeight / 2
        
        
        greenProgressBar.backgroundColor = .greenSuccess
        greenProgressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greenProgressBar)
        greenProgressBar.leadingAnchor.constraint(equalTo: shadowProgressBar.leadingAnchor).isActive = true
        greenProgressBar.heightAnchor.constraint(equalToConstant: barHeight).isActive = true
        greenProgressBar.centerYAnchor.constraint(equalTo: shadowProgressBar.centerYAnchor).isActive = true
        greenProgressBar.layer.cornerRadius = barHeight / 2
    }
}
