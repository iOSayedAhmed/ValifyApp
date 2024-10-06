//
//  MainViewModel.swift
//  Paymob-Task
//
//  Created by iOSAYed on 06/07/2024.
//

import Foundation

class MainViewModel {
    weak var coordinator: MainViewControllerCoordinator?
    
    init(coordinator: MainViewControllerCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
}
