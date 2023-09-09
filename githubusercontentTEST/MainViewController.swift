//
//  MainViewController.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    
}

// MARK: - Lifecircle

extension MainViewController {
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

