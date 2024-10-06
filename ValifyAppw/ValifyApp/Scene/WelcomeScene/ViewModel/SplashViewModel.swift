//
//  SplashScreenViewModel.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import Combine
import Foundation

protocol SplachViewModelType {
    var animationCompleted: CurrentValueSubject<Bool, Never> { get }
    func animationDidFinish()
    func goToMainView()
    func didDisAppear()
}

final class SplashViewModel: SplachViewModelType {
    weak var coordinator: SplashCoordinator?
    
    init(coordinator: SplashCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    let animationCompleted: CurrentValueSubject<Bool, Never> = .init(false)

    func animationDidFinish() {
        animationCompleted.send(true)
    }
    
    func goToMainView() {
        coordinator?.startMainTabBarCoordinator()
    }
    
    func didDisAppear() {
        coordinator?.didDisAppear()
    }
}
