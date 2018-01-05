//
//  ImageModel.swift
//  Cards
//
//  Created by Marek Fořt on 9/20/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift



protocol ImageModeling  {
    
}

class ImageModel: ImageModeling, ImageSettable {
    
    var picture: String? = nil
    
    var downloadedImage: MutableProperty<UIImage?> = MutableProperty(nil)
    var isImageBeingDownloaded: MutableProperty<Bool> = MutableProperty(false)
    
    var downloadImageAction: Action<String?, UIImage?, ConnectionError>?
    
    init() {
        let downloadImageAction = ImageModel.createAction()
        self.downloadImageAction = downloadImageAction
        setupBindings()
    }
    
    private func setupBindings() {
        downloadImageAction?.isExecuting.producer.startWithValues { [weak self] isExecuting in
            self?.isImageBeingDownloaded.value = isExecuting
        }
    }
}
