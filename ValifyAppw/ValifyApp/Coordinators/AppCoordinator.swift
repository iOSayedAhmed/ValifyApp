//
//  AppCoordinator.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController = UINavigationController()

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        startSplashScreen()
    }

    func startSplashScreen() {
        let splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator.parentCoordinator = self
        childCoordinators.append(splashCoordinator)
        splashCoordinator.start()
    }

    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator in
            childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
