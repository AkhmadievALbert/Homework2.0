//
//  MessageTableViewCell.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
    // MARK: Private structures
    
    private struct Constants {
        static let labelLeading: CGFloat = 8
        static let imageWidthHeight: CGFloat = 40
        static let descriptionLabelTop: CGFloat = 4
        static let contentTopLeadingBottomTrailing: CGFloat = 24
    }
    
    
    // MARK: Display data structure
    
    struct DisplayData {
        let image: UIImage?
        let username: String
        let description: String
        let date: String
    }
    
    
    // MARK: Private properties
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorHelper.messageDescriptionColor
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorHelper.messageDateColor
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    // MARL: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: Public
    
    func configure(displayData: DisplayData) {
        
        if let image = displayData.image {
            avatarImageView.image = image
        } else {
            guard let firstCharacter = displayData.username.first else {
                return
            }
            let label = UILabel()
            label.textColor = ColorHelper.imageLabelColor
            label.text = "\(firstCharacter)"
            avatarImageView.addSubview(label)
            avatarImageView.backgroundColor = ColorHelper.imagePlaceholderColor
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        }
        usernameLabel.text = displayData.username
        descriptionLabel.text = displayData.description
        dateLabel.text = displayData.date
    }
    
    
    // MARK: Private
    
    private func setupView() {
        self.addSubview(avatarImageView)
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageWidthHeight).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.descriptionLabelTop
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.labelLeading).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        stackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -Constants.contentTopLeadingBottomTrailing).isActive = true
        
        
        self.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.contentTopLeadingBottomTrailing).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.contentTopLeadingBottomTrailing).isActive = true
    }
}
