//
//  MainTableViewCell.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

protocol MainTableViewCellDelegate: AnyObject {
    func showText(_ cell: MainTableViewCell)
}

class MainTableViewCell: UITableViewCell {
    
    static let id = "MainTableViewCell"
    weak var delegate: MainTableViewCellDelegate?
    var isExpanded = true
    
    let titleLabel: UILabel = {
        let view = UILabel()
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
        view.textColor = .secondaryLabel
        view.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let likeCountLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeshampLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.font = .boldSystemFont(ofSize: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let button: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = 8
        view.backgroundColor = .blue
        view.setTitle("Eхpand", for: .normal)
        view.isUserInteractionEnabled = true
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
    
    @objc func showText(sender: UIButton) {
        delegate?.showText(self)
        if isExpanded {
            isExpanded = false
            sender.setTitle("Collapse", for: .normal)
            previewText.numberOfLines = 0
        } else {
            isExpanded = true
            sender.setTitle("Eхpand", for: .normal)
            previewText.numberOfLines = 2
        }
        layoutIfNeeded()
    }
}
// MARK: - Configuration

extension MainTableViewCell {
    private func setup() {
        button.addTarget(self, action: #selector(showText), for: .touchUpInside)

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
            
            likeCountLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 12),
            likeCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            timeshampLabel.topAnchor.constraint(equalTo: previewText.bottomAnchor, constant: 12),
            timeshampLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
           
            button.topAnchor.constraint(equalTo: likeCountLabel.bottomAnchor, constant: 12),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
}
