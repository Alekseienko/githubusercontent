//
//  MainTableViewCell.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let id = "MainTableViewCell"
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "The Ingenious Prank Music Legend Mozart Played On Someone He Couldn’t Stand"
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .left
        view.textColor = .label
        view.lineBreakMode = .byTruncatingTail
        view.numberOfLines = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let previewText: UILabel = {
        let view = UILabel()
        view.text = "When we think of famous bands, we have an image of each member’s distinctive roles. More often than not, every member has clearly defined roles that they stick to from beginning to end.When we think of famous bands, we have an image of each member’s distinctive roles. More often than not, every member has clearly defined roles that they stick to from beginning to end.When we think of famous bands, we have an image of each member’s distinctive roles. More often than not, every member has clearly defined roles that they stick to from beginning to end.When we think of famous bands, we have an image of each member’s distinctive roles. More often than not, every member has clearly defined roles that they stick to from beginning to end."
        view.textColor = .secondaryLabel
        view.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likeCountLabel: UILabel = {
        let view = UILabel()
        view.text = "❤️ 4534534"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeshampLabel: UILabel = {
        let view = UILabel()
        view.text = "21 ago"
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let button: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .blue
        view.setTitle("Epand", for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
// MARK: - Configuration

extension MainTableViewCell {
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(previewText)
        contentView.addSubview(button)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(timeshampLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            previewText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            previewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            previewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            likeCountLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 12),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            likeCountLabel.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -12),
            
            timeshampLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 12),
            timeshampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            timeshampLabel.bottomAnchor.constraint(equalTo: button.topAnchor,constant: -12),
        ])
        
    }
}
