//
//  SplashCoordinator.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import Foundation
import UIKit

class SplashCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashScreenViewModel = SplashViewModel(coordinator: self)
        let splashScreenVC = SplashVC(viewModel: splashScreenViewModel, nibName: "\(SplashVC.self)")
        splashScreenVC.viewModel = splashScreenViewModel
        navigationController.setViewControllers([splashScreenVC], animated: true)
    }
  
    func startMainTabBarCoordinator() {
        let mainViewCoordinator = MainViewControllerCoordinator(navigationController: navigationController)
        mainViewCoordinator.navigationController.navigationBar.isHidden = true
        childCoordinators.append(mainViewCoordinator)
        mainViewCoordinator.start()
    }
    
    func didDisAppear() {
        parentCoordinator?.childDidFinish(self)
    }

    deinit {
        print(" Coordinator Deallocted")
    }
}
