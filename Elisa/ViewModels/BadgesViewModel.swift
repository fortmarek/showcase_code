//
//  BadgesViewModel.swift
//  Cards
//
//  Created by Marek Fořt on 9/9/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

protocol BadgesViewModeling {
    var badges: MutableProperty<[Badge]> {get set}
    func getBadges() -> SignalProducer<[Badge], ConnectionError>
    func getNewBadges() -> SignalProducer<[Badge], ConnectionError>
    func setupBadgesBindings()
}

extension BadgesViewModeling where Self: APIService {
    func getBadges() -> SignalProducer<[Badge], ConnectionError> {
        return SignalProducer<[Badge], ConnectionError> { [weak self] sink, disposable in
            self?.getCodableStruct(subpath: "profile/badges", codableType: BadgesStruct.self).startWithResult { result in
                guard let badges = result.value?.achievements else {sink.send(error: .DecodeError); return}
                self?.badges.value = badges
                //sink.send(value: badges)
                sink.sendCompleted()
            }
        }
    }
    
    func getNewBadges() -> SignalProducer<[Badge], ConnectionError> {
        return SignalProducer<[Badge], ConnectionError> { [weak self] sink, disposable in
            self?.getCodableStruct(subpath: "profile/badges/new", codableType: BadgesStruct.self).startWithResult { result in
                guard let badges = result.value?.achievements else {sink.send(error: .DecodeError); return}
                self?.badges.value = badges
                sink.send(value: badges)
                sink.sendCompleted()
            }
        }
    }
    
    func setupBadgesBindings() {
        badges.producer.observe(on: UIScheduler()).startWithValues { badges in
            badges.forEach{$0.imageModel.setPreviewImage(path: $0.picture)}
        }
    }
}


class BadgesViewModel: APIService, BadgesViewModeling  {
    var badges: MutableProperty<[Badge]> = MutableProperty<[Badge]>([])
}

