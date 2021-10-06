//
//  MessageCollectionViewCell.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

final class MessageCollectionViewCell: UICollectionViewCell {
    
    // MARK: Private structures
    
    private struct Constants {
        static let topContent: CGFloat = 16
        static let labelHeight: CGFloat = 16
        static let labelSpacing: CGFloat = 8
        static let bottomContent: CGFloat = 20
        static let imageWidthHeight: CGFloat = 48
        static let leadingTrailingContent: CGFloat = 16
    }
    
    
    // MARK: Display data structure
    
    struct DisplayData {
        let image: UIImage?
        let username: String
    }
    
    
    // MARK: Private properties
    
    private let avatarImageView = UIImageView()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Public
    
    func configure(displayData: DisplayData) {
        userNameLabel.text = displayData.username
        if let image = displayData.image {
            avatarImageView.image = image
            
        } else {
            guard let firstCharacter = displayData.username.first else {
                return
            }
            let label = UILabel()
            label.textColor = ColorHelper.imageLabelColor
            label.text = "\(firstCharacter)"
            avatarImageView.backgroundColor = ColorHelper.imagePlaceholderColor
            avatarImageView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        }
    }
    
    
    //MARK: Private
    
    private func setupView() {
        addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        layoutIfNeeded()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.layer.masksToBounds = false
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        
        addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,
                                           constant: Constants.labelSpacing).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight).isActive = true
    }
}
