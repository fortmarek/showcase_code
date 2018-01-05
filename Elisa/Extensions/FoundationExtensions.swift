//
//  FoundationExtensions.swift
//  Cards
//
//  Created by Marek Fořt on 8/6/17.
//  Copyright © 2017 Marek Fořt. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func getImage() -> SignalProducer<UIImage, NoError>{
        let apiService = APIService()
        return SignalProducer<UIImage, NoError> { sink, disposable in
            apiService.getData(path: self).startWithResult {result in
                guard
                    let imageData = result.value,
                    let image = UIImage(data: imageData)
                else {return}
                sink.send(value: image)
            }
        }
    }
}

extension Sequence {
    func deselectAllButtons() {
        for element in self {
            guard let button = element as? UIButton else {continue}
            button.deselect() 
        }
    }
}

extension Collection {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}

extension Array {
    func ref(_ index: Int) -> Element? {
        guard self.count > index else {return nil}
        return self[index]
    }
}

extension NSObject {
    func unimplemented() -> Never {
        fatalError("This code path is not implemented yet.")
    }
}

//https://stackoverflow.com/questions/34460823/round-double-to-0-5

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}

extension URLRequest {
    mutating func setCredentialsHeader() {
        let userManager = UserManager()
        if let credentials = userManager.getCredentials() {
            setValue("\(credentials.tokenType.capitalized) \(credentials.accessToken)", forHTTPHeaderField: "Authorization")
        }
    }
}

extension String {
    func stringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)
        guard let finalDate = date else {return Date()}
        return finalDate
    }
}

extension Date {
    
    static var today: Date {
        return Date()
    }
    
    func getDaysAgo() -> String {
        
        if let numberOfMinutesAgo = numberOfStringAgo(component: (.minute, L10n.Date.minute, L10n.Date.minutes), bottomLimit: 1, topLimit: 60) {
            return numberOfMinutesAgo
        }
        
        if let numberOfDaysAgo = numberOfStringAgo(component: (.hour, L10n.Date.hour, L10n.Date.hours), bottomLimit: 1, topLimit: 24) {
            return numberOfDaysAgo
        }
        
        if let numberOfDaysAgo = numberOfStringAgo(component: (.day, L10n.Date.day, L10n.Date.days), bottomLimit: 1, topLimit: 30) {
            return numberOfDaysAgo
        }
        
        if let numberOfMonthsAgo = numberOfStringAgo(component: (.month, L10n.Date.month, L10n.Date.months), bottomLimit: 1, topLimit: 12) {
            return numberOfMonthsAgo
        }
        
        if let numberOfYearsAgo = numberOfStringAgo(component: (.year, L10n.Date.year, L10n.Date.years), bottomLimit: 1, topLimit: Int.max) {
            return numberOfYearsAgo
        }
        
        return L10n.Date.recently
    }
    
    func numberOfStringAgo(component: (Calendar.Component, String, String), bottomLimit: Int, topLimit: Int) -> String? {
        let numberOfUnitsAgo = Date.today.number(of: component.0, from: self)
        if numberOfUnitsAgo == bottomLimit {
            return L10n.Date.ago(numberOfUnitsAgo, component.1)
        }
        else if numberOfUnitsAgo < topLimit {
            return L10n.Date.ago(numberOfUnitsAgo, component.2)
        }
        return nil
    }
    
    
    func number(of component: Calendar.Component, from date: Date) -> Int {
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let dateComponent = myCalendar.dateComponents([component], from: date, to: self)
        guard let dateValue = dateComponent.value(for: component) else {return 0}
        return dateValue
    }

    
}


extension DispatchQueue {
    func async(after seconds: Float, execute: @escaping () -> Void) {
        let afterTime = DispatchTime.now().uptimeNanoseconds + UInt64(seconds * Float(NSEC_PER_SEC))
        self.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: afterTime), execute: execute)
    }
}

extension Data {
    
    mutating func append(_ string: String) {
        guard let data = string.data(using: .utf8) else {return}
        append(data)
    }
}
