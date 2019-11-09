// FrogogoTestApp
// Created on 10.11.2019
//
// Copyright © 2019 Oleg Mosyagin. All rights reserved.

import Foundation

/**
 This class provide simple binding mechanism. When value did change it calls a listener closure
 */
class Box <T> {
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    
    
    // MARK: - Lifecycle methods
    init(value: T) {
        self.value = value
    }
    
    
    
    // MARK: - Custom open/public/internal methods
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
