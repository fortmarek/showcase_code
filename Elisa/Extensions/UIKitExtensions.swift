//
//  UIKitExtensions.swift
//  Cards
//
//  Created by Marek Fořt on 8/6/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result
import SafariServices

extension UIView {
    func pinToView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func pinToViewHorizontally(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func pinToViewVertically(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func centerInView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func pinToViewWithInsets(_ view: UIView, insets: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right).isActive = true
    }
    
    func setHeightAndWidthAnchorToConstant(_ constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        widthAnchor.constraint(equalToConstant: constant).isActive = true 
    }
    
    func setAnchorsToSizeToFit() {
        sizeToFit()
        widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        heightAnchor.constraint(equalToConstant: frame.height).isActive = true 
    }
    
    //Needed when view.clipsToBounds = true => shadow as a child of that view could not go over the bounds of that view
    func addShadowLayer(_ shadowLayer: CALayer) {
        let backgroundShadowView = UIView()
        backgroundShadowView.translatesAutoresizingMaskIntoConstraints = false
        superview?.addSubview(backgroundShadowView)
        superview?.sendSubview(toBack: backgroundShadowView)
        backgroundShadowView.backgroundColor = .cornflower
        backgroundShadowView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        backgroundShadowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        backgroundShadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundShadowView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundShadowView.layer.shadowColor = shadowLayer.shadowColor
        backgroundShadowView.layer.shadowRadius = shadowLayer.shadowRadius
        backgroundShadowView.layer.shadowOpacity = shadowLayer.shadowOpacity
        backgroundShadowView.layer.shadowOffset = shadowLayer.shadowOffset

        backgroundShadowView.clipsToBounds = false
    }
    
    func isLocationInside(location: CGPoint, mainSuperview: UIView) -> Bool {
        let convertedFrame = convert(bounds, to: mainSuperview)
        return convertedFrame.contains(location)
    }

    
}

extension UIFont {
    func getHeight() -> CGFloat{
        let label = UILabel()
        label.text = " "
        label.font = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func getWidthOfText(_ text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = self
        label.sizeToFit()
        return label.frame.width
    }
}

extension UILabel {
    func setScaledFont(_ font: UIFont) {
        if #available(iOS 11.0, *) {
            adjustsFontForContentSizeCategory = true
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
        else {
            self.font = font
        }
    }
}

extension UIViewController {
    func preloadView() {
        let _ = view
    }
    
        func share(title: String, sourceView: UIView?, completion: (() -> Void)?) {
        let myText = title
        let myObjects = [myText] as [Any]
        let activityVC = UIActivityViewController(activityItems: myObjects, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.addToReadingList, .airDrop]
        activityVC.popoverPresentationController?.sourceView = sourceView
        present(activityVC, animated: true, completion: completion)
    }
    
    func share(title: String, barButtonItem: UIBarButtonItem?, completion: (() -> Void)?) {
        let myText = title
        let myObjects = [myText] as [Any]
        let activityVC = UIActivityViewController(activityItems: myObjects, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.addToReadingList, .airDrop]
        activityVC.popoverPresentationController?.barButtonItem = barButtonItem
        present(activityVC, animated: true, completion: completion)
    }
    
    func presentWebpage(path: String) {
        guard let url = URL(string: path) else {return}
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .cornflower
        present(safariViewController, animated: true, completion: nil)
    }
    
}

extension UIStackView {
    func addBackgroundViewWithColor(_ color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundView)
        backgroundView.pinToView(self)
    }
    
    static func createDefaultVerticalStackView() -> UIStackView {
        let defaultVerticalStackView = UIStackView()
        defaultVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        defaultVerticalStackView.alignment = .center
        defaultVerticalStackView.axis = .vertical
        return defaultVerticalStackView
    }
}

extension UIImage {
    
    convenience init?(color: UIColor, size: CGSize?) {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    static func downloadImage(path: String?) -> SignalProducer<UIImage?, ConnectionError> {
        let apiService = APIService()
        return SignalProducer<UIImage?, ConnectionError> { sink, disposable in
            guard let path = path else {sink.send(error: .URLError); return}
            apiService.getData(path: path).startWithResult { result in
                guard let imageData = result.value else {return}
                sink.send(value: UIImage(data: imageData))
                sink.sendCompleted()
            }
        }
    }
}

extension UIImageView {
    func downloadImageWithPath(_ path: String?, animated: Bool = false) {
        guard let path = path else {return}
        self.contentMode = contentMode
        let apiService = APIService()
        apiService.getData(path: path).observe(on: UIScheduler()).startWithResult {[weak self] result in
            guard let imageData = result.value else {return}
            let image = UIImage(data: imageData)
            self?.setImage(image, animated: animated)
        }
    }
    
    func downloadImageIfNeeded(downloadedImage: UIImage?, path: String?) {
        if let downloadedImage = downloadedImage {
            image = downloadedImage
        }
        else {
            downloadImageWithPath(path)
        }
    }
    
    func setImage(_ image: UIImage?, animated: Bool) {
        guard let image = image else {return}
        guard animated else {
            self.image = image
            return
        }
        guard let superview = self.superview else {return}
        let placeholderImageView = UIImageView()
        placeholderImageView.alpha = 0.0
        placeholderImageView.image = image
        placeholderImageView.clipsToBounds = true
        placeholderImageView.layer.cornerRadius = layer.cornerRadius
        placeholderImageView.contentMode = contentMode
        superview.addSubview(placeholderImageView)
        placeholderImageView.pinToView(self)
        UIView.animate(withDuration: 0.3, animations: {
            placeholderImageView.alpha = 1.0
        }, completion: { [weak self] _ in
            self?.image = image
            placeholderImageView.removeFromSuperview()
        })
        
    }
    
    func bind(with imageModel: ImageModel, animated: Bool = true, defaultImage: UIImage? = nil) {
        let shouldAnimate: Bool = imageModel.downloadedImage.value == nil
        imageModel.downloadedImage.producer.observe(on: UIScheduler()).startWithValues { [weak self] image in
            guard imageModel.isImageBeingDownloaded.value == false else {return}
            self?.setImage(image ?? defaultImage, animated: shouldAnimate && animated)
        }
        imageModel.setPreviewImage(path: imageModel.picture)
    }
}

extension UITextField {
    func setLeftPadding(_ padding: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        self.leftView = leftView
        leftViewMode = .always
    }
    
    func setRightPadding(_ padding: CGFloat) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        self.rightView = rightView
        rightViewMode = .always
    }
}

extension UIButton {
    func reselect() {
        self.isSelected = !self.isSelected
    }
    
    func deselect() {
        guard isSelected else {return}
        isSelected = !isSelected
    }
}

extension UITableView {
    func cellFromDataSource(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = self.dataSource?.tableView(self, cellForRowAt: indexPath)
        return cell
    }
}


extension UINavigationController {
    
    func setDefaultBackButtonWithTitle(_ title: String) {
        let backImage = UIImage(asset: Asset.back)
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationBar.tintColor = .cornflower
    }
    
    func setDefaultNavigationBar() {
        navigationBar.backgroundColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .white
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
            navigationBar.prefersLargeTitles = true
        }
    }
}


extension UIScreen {
    static var widthInPortrait: CGFloat {
        return min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    static var heightInPortrait: CGFloat {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }
    
    static var isInPortrait: Bool {
        return UIScreen.main.bounds.height > UIScreen.main.bounds.width
    }
}

extension UICollectionView {
    var minimumInterimSpacing: CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
    }
    var minimumLineSpacing: CGFloat {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
    }
}

extension UICollectionViewCell {
    static func getCellWidth(xEdgeInset: CGFloat, minInterimSpacing: CGFloat, numberOfItemsInRow: Int) -> CGFloat {
        let numberOfSpaces: CGFloat = CGFloat(numberOfItemsInRow) - 1
        let cellWidth: CGFloat = (UIScreen.widthInPortrait - 2 * xEdgeInset - minInterimSpacing * numberOfSpaces) / CGFloat(numberOfItemsInRow)
        return cellWidth
    }
}

extension NSLayoutConstraint {
    func activate(with priority: UILayoutPriority) {
        self.priority = priority
        isActive = true
    }
}

