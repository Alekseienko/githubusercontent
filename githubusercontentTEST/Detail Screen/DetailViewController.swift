//
//  DetailViewController.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    private let mainView = DetailView()
    
}

// MARK: - Lifecircle

extension DetailViewController {
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
}

extension DetailViewController {
    private func config() {
        navigationItem.title = "title"
    }
}
