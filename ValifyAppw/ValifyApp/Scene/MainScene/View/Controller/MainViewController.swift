//
//  MainViewController.swift
//  ValifyApp
//
//  Created by iOSAYed on 06/10/2024.
//

import UIKit
import ValifyCapture

class MainViewController: UIViewController {

    
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
    }
    
    
}

extension MainViewController {
    private func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView(){
        
    }
}
