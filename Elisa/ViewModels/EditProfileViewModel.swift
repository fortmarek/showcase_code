//
//  EditProfileViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 9/21/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift


protocol EditProfileViewModeling {
    
}


class EditProfileViewModel: APIService, EditProfileViewModeling, UserDownloadable {
    var user: MutableProperty<DetailUser?> = MutableProperty(nil)
    var fullname: MutableProperty<String> = MutableProperty("")
    var imageModel: MutableProperty<ImageModel?> = MutableProperty(nil)
    
    override init() {
        super.init()
        setupBindings()
    }

    private func setupBindings() {
        
        let userProducer = user.producer.skipNil()
        fullname <~ userProducer.map {$0.fullname}
        imageModel <~ userProducer.map {$0.imageModel}
    }
    
    
    lazy var updateFullname: Action<String, String, ConnectionError> = {
        Action { fullname in
            return SignalProducer<String, ConnectionError> { [weak self] sink, disposable in
                let jsonDictionary: [String: Any] = ["fullname": fullname]
                self?.putData(jsonDictionary: jsonDictionary, subpath: "profile").startWithResult { result in
                    guard result.error == nil else {sink.send(error: ConnectionError.DecodeError); return}
                    sink.send(value: fullname)
                    sink.sendCompleted()
                }
            }
        }
    }()
}
