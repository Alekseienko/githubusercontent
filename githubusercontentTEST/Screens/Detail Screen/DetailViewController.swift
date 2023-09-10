//
//  DetailViewController.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    private let mainView = DetailView()
    var postID: Int!
    var postDetailData: PostDetailData!
}

// MARK: - Lifecircle

extension DetailViewController {
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchData()
    }
}

extension DetailViewController {
    private func config() {
        navigationItem.title = "Post ID " + String(postID)
        mainView.activity.startAnimating()
    }
    
    private func fetchData() {
        let stringURL = Constants.postURL.replacingOccurrences(of: "[id]", with: String(postID))
        guard let url = URL(string: stringURL) else {
            Helper.shared.showCustomAlert(title: "Oops", message: "Some proplem with POST URL", viewController: self)
            return}
        
        NetworkManager.shared.fetchData(from: url, responseType: PostDetailData.self) { result in
            switch result {
            case .success(let postDetailData):
                do {
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let data = try encoder.encode(postDetailData)
                    self.postDetailData = postDetailData
                    
                    DispatchQueue.main.async {
                        self.mainView.titleLabel.text = postDetailData.post.title
                        self.mainView.previewText.text = postDetailData.post.text
                        self.mainView.likeCountLabel.text = "❤️ " + String(postDetailData.post.likesCount)
                        self.mainView.timeshampLabel.text = Helper.shared.getTimeSince(timeshamp: postDetailData.post.timeshamp)
                        self.mainView.imageView.loadImage(from: postDetailData.post.postImage) { loaded in
                            switch loaded {
                            case .none:
                                print("❌")
                            case .some(_):
                                self.mainView.activity.stopAnimating()
                            }
                        }
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
