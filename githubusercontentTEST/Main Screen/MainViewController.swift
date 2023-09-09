//
//  MainViewController.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class MainViewController: UIViewController {
    private let mainView = MainView()
    var mainPosts: [Post] = []
}

// MARK: - Lifecircle

extension MainViewController {
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchData()
    }
}

// MARK: - Configuration

extension MainViewController {
    
    private func config() {
        navigationItem.title = "App"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
    }
    
    @objc private func test() {
        print("⚠️", #function)
    }
    
    private func fetchData() {
        guard let url = URL(string: Constants.mainURL) else {
            Helper.shared.showCustomAlert(title: "Oops", message: "Some proplem with MAIN URL", viewController: self)
            return }
        
        NetworkManager.shared.fetchData(from: url, responseType: Posts.self) { result in
            switch result {
            case .success(let posts):
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try encoder.encode(posts)
                    self.mainPosts = posts.posts
                    
                    DispatchQueue.main.async {
                        self.mainView.tableView.reloadData()
                    }
                    // Для отладки
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received posts:\n\(jsonString)")
                    } else {
                        print("Unable to convert data to UTF-8 string.")
                    }
                } catch {
                    print("Error encoding or converting data: \(error)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        mainPosts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as? MainTableViewCell else {return UITableViewCell()
        }
        let post = mainPosts[indexPath.section]
        cell.titleLabel.text = post.title
        cell.previewText.text = post.previewText
        cell.likeCountLabel.text = "❤️ " + String(post.likesCount)
        cell.timeshampLabel.text = String(Helper.shared.getTimeSince(timeshamp: post.timeshamp))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = mainPosts[indexPath.section]
        let viewController = DetailViewController()
        viewController.postID = post.postID
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
