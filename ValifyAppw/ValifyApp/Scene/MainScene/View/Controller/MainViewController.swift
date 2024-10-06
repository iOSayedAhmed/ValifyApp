//
//  MainViewController.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import UIKit
import ValifyCapture
import Combine

class MainViewController: UIViewController {

    //MARK: OUTLETS
    
    @IBOutlet weak var capturedSelfiImageView: UIImageView!
    @IBOutlet weak var takeSelfiButton: UIButton!
    
    
    private var cancellables = Set<AnyCancellable>()
    
    var viewModel: MainViewModel!
    
    init(viewModel: MainViewModel, nibName: String) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setupView()
        bind()
    }
    
    
}

extension MainViewController {
    private func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView(){
        takeSelfiButton.layer.cornerRadius = 12
    }
    
    private func bind(){
        takeSelfiButton.publisher(for: .touchUpInside)
            .receive(on: RunLoop.main)
            .sink{ [weak self] _ in
                guard let self else {return}
                CameraViewController.show(from: self, delegate: self)
                
                // If you installed ValifyCapture Pod version -> (1.0.1)
                // please use the below code to present CameraVC
                /*
                 let cameraVC = CameraViewController()
                 cameraVC.modalPresentationStyle = .fullScreen
                 cameraVC.viewModel = CameraViewModel()
                 cameraVC.delegate = self
                 present(cameraVC, animated: true, completion: nil)
                */
                 
            }
            .store(in: &cancellables)
    }
}

extension MainViewController: CameraDelegate {
    func didCaptureImage(_ image: UIImage) {
        capturedSelfiImageView.image = image
    }
    
    func didFailWithError(_ error: Error) {
        print("Error ===> \(error.localizedDescription)")
    }
  
}
