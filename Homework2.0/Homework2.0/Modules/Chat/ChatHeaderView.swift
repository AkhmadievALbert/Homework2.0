//
//  ChatHeaderView.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 11.10.2021.
//

import UIKit

final class ChatHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Private structures
    
    private enum Constants {
        static let edgesInset: CGFloat = 6
    }
    
    // MARK: Private properties
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func configure(dateString: String) {
        dateLabel.text = dateString
    }
    
    // MARK: Private
    
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.edgesInset)
            $0.centerX.equalToSuperview()
        }
    }
}
