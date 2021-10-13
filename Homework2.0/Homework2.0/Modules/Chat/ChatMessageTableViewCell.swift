//
//  ChatMessageTableViewCell.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 11.10.2021.
//

import SnapKit
import UIKit

final class ChatMessageTableViewCell: UITableViewCell {
    
    // MARK: Private data structures
    
    private struct Constants {
        static let top: CGFloat = 18
        static let bottom: CGFloat = 6
        static let leading: CGFloat = 16
        static let trailing: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let avatarSize = CGSize(width: 32, height: 32)
        static let textInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    // MARK: DisplayData structure
    
    struct DisplayData {
        let isExternal: Bool
        let image: UIImage?
        let message: String
        let date: String
    }
    
    // MARK: Private properties

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Public
    
    func configure(displayData: DisplayData) {
        messageTextLabel.text = displayData.message
        dateLabel.text = displayData.date.description

        if displayData.isExternal {
            avatarImageView.image = UIImage(named: "ProfilePhoto-1")
            setupViewForIsExternal()
        } else {
            setupViewForIsNotExternal()
        }
    }
    
    // MARK: Private
    
    private func setupViewForIsExternal() {
        selectionStyle = .none

        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.top)
            $0.leading.equalToSuperview().inset(Constants.leading)
            $0.size.equalTo(Constants.avatarSize)
        }

        contentView.addSubview(messageView)
        messageView.backgroundColor = ColorHelper.imagePlaceholderColor
        messageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.top)
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.textInsets.top)
            $0.trailing.lessThanOrEqualToSuperview().inset(Constants.trailing)
        }
        
        messageView.addSubview(messageTextLabel)
        messageTextLabel.textColor = .label
        messageTextLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Constants.textInsets)
        }

        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(messageView.snp.bottom).offset(Constants.textInsets.bottom)
            $0.bottom.equalToSuperview().inset(Constants.bottom)
            $0.trailing.equalTo(messageView.snp.trailing)
        }
    }

    private func setupViewForIsNotExternal() {
        selectionStyle = .none

        contentView.addSubview(messageView)
        messageView.backgroundColor = .systemBlue
        messageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.top)
            make.trailing.equalToSuperview().inset(Constants.trailing)
            make.leading.greaterThanOrEqualToSuperview().offset(Constants.leading)
        }

        messageView.addSubview(messageTextLabel)
        messageTextLabel.textColor = .white
        messageTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.textInsets)
        }
        messageTextLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageView.snp.bottom).offset(Constants.textInsets.bottom)
            make.bottom.equalToSuperview().inset(Constants.bottom)
            make.trailing.equalToSuperview().inset(Constants.trailing)
            make.leading.greaterThanOrEqualToSuperview().offset(Constants.leading)
        }
        dateLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
