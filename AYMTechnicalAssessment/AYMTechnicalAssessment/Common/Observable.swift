//
//  Observable.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
class Observable<T> {
    typealias Observer = (T) -> Void
    var observer: Observer?
    
    func observe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
