//
//  BaseViewModel.swift
//  Ounass
//
//  Created by Hakkı Yiğit Yener on 6.02.2022.
//

import Foundation

protocol StateChange { }

class BaseViewModel<SC: StateChange> {
    
    typealias StateChangeHandler = (SC) -> Void
    
    private var stateChangeHandlers: [StateChangeHandler] = []

    final func addChangeHandler(_ handler: @escaping StateChangeHandler) {
        stateChangeHandlers.append(handler)
    }

    final func emit(change: SC) {
        stateChangeHandlers.forEach({ (handler: @escaping StateChangeHandler) in
            DispatchQueue.main.async {
                handler(change)
            }
            
        })
    }
}
