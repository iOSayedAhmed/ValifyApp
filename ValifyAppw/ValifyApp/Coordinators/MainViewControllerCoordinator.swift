//
//  MainViewControllerCoordinator.swift
//  Paymob-Task
//
//  Created by iOSAYed on 06/07/2024.
//

import Foundation
import UIKit

final class MainViewControllerCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainViewModel = MainViewModel(coordinator: self)
        let mainVC = MainViewController(viewModel: mainViewModel, nibName: "\(MainViewController.self)")
        navigationController.tabBarController?.tabBar.isHidden = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(mainVC, animated: true)
    }
}
