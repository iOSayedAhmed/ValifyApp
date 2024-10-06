//
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.

import Combine
import UIKit

class SplashVC: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var logoImageView: UIImageView!
    
    // MARK: - Propreties

    var viewModel: SplachViewModelType!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SplachViewModelType, nibName: String) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        animateImageView()
        bindingViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.didDisAppear()
    }
    
    // MARK: - methods
    
    func animateImageView() {
        guard logoImageView != nil else {
            print("Error: logoImageView is nil")
            return
        }
        logoImageView.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 2.0, animations: {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = CGAffineTransform.identity
        }) { [weak self] _ in
            self?.viewModel.animationDidFinish()
        }
    }
    
    private func bindingViewModel() {
        guard let viewModel = viewModel else {
            print("Error: viewModel is nil")
            return
        }
        viewModel.animationCompleted
            .sink { [weak self] isCompleted in
                guard let _ = self else { return }
                if isCompleted {
                    viewModel.goToMainView()
                } else {
                    print("The animation is not complete yet!")
                }
            }
            .store(in: &cancellables)
    }
}
