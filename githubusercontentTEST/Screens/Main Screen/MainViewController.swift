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
    var selectedIndexes: [Int] = []
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
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(didTapSort))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
    }
    
    @objc private func didTapSort() {
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .actionSheet)
       
        let sortByLikesUp = UIAlertAction(title: "By Likes >", style: .default) { UIAlertAction in
            let sortedPosts = self.mainPosts.sorted { $0.likesCount > $1.likesCount }
            self.mainPosts = sortedPosts
            self.mainView.tableView.reloadData()
        }
        let sortByLikesDown = UIAlertAction(title: "By Likes <", style: .default) { UIAlertAction in
            let sortedPosts = self.mainPosts.sorted { $0.likesCount < $1.likesCount }
            self.mainPosts = sortedPosts
            self.mainView.tableView.reloadData()
        }
        let sortByDateUp = UIAlertAction(title: "By Date >", style: .default) { UIAlertAction in
            let sortedPosts = self.mainPosts.sorted { $0.timeshamp > $1.timeshamp }
            self.mainPosts = sortedPosts
            self.mainView.tableView.reloadData()
        }
        let sortByDateDown = UIAlertAction(title: "By Date <", style: .default) { UIAlertAction in
            let sortedPosts = self.mainPosts.sorted { $0.timeshamp < $1.timeshamp }
            self.mainPosts = sortedPosts
            self.mainView.tableView.reloadData()
        }
        alert.addAction(sortByLikesUp)
        alert.addAction(sortByLikesDown)
        alert.addAction(sortByDateUp)
        alert.addAction(sortByDateDown)
        alert.addAction(UIAlertAction(title: "Cancle", style: .destructive, handler: nil))
        self.present(alert, animated: true)
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
        cell.delegate = self
        let post = mainPosts[indexPath.section]
        cell.titleLabel.text = post.title
        cell.previewText.text = post.previewText
        cell.likeCountLabel.text = "❤️ " + String(post.likesCount)
        cell.timeshampLabel.text = String(Helper.shared.getTimeSince(timeshamp: post.timeshamp))

        if !selectedIndexes.contains(where: { $0 == post.postID }) {
            cell.previewText.numberOfLines = 2
            cell.button.setTitle("Expand", for: .normal)
        } else {
            cell.previewText.numberOfLines = 0
            cell.button.setTitle("Collapse", for: .normal)
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        selectedIndexes = []
    }
}

// MARK: - MainTableViewCellDelegate

extension MainViewController: MainTableViewCellDelegate {
    func showText(_ cell: MainTableViewCell) {
        guard let indexPath = mainView.tableView.indexPath(for: cell) else { return }
        
        let elementIndex = mainPosts[indexPath.section].postID
        if let index = selectedIndexes.firstIndex(where: { $0 == elementIndex }) {
            selectedIndexes.remove(at: index)
        } else {
            selectedIndexes.append(elementIndex)
        }
        mainView.tableView.reloadData()
    }
}
