//
//  DetailView.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class DetailView: UIView {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let activity: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .blue
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .left
        view.textColor = .label
        view.lineBreakMode = .byTruncatingTail
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let previewText: UITextView = {
        let view = UITextView()
        view.textColor = .secondaryLabel
        view.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likeCountLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeshampLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
    }
}

// MARK: - Configuration

extension DetailView {
    private func setup() {
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(activity)
        addSubview(titleLabel)
        addSubview(previewText)
        addSubview(likeCountLabel)
        addSubview(timeshampLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activity.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            previewText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            previewText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            previewText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            likeCountLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 4),
            likeCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            likeCountLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            timeshampLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 4),
            timeshampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            timeshampLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}
