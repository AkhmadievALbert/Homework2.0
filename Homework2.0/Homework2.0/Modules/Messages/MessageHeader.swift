//
//  MessageHeader.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

final class MessageHeader: UITableViewHeaderFooterView {
    
    // MARK: Private structors
    
    private struct Constants {
        static let topTitle: CGFloat = 11
        static let topCollection: CGFloat = 11
        static let leadingTrailing: CGFloat = 24
        static let bottomCollection: CGFloat = 20
        static let collectionItemWidth: CGFloat = 64
        static let collectionItemHeight: CGFloat = 72
        static let forCellWithReuseIdentifier = "MessageCollectionCell"
    }
    
    // MARK: Private properties
    
    private var pinned: [MessagesDisplayData.Message] = []
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: Constants.collectionItemWidth, height: Constants.collectionItemHeight)
        flowLayout.minimumInteritemSpacing = 0.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.forCellWithReuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        return collectionView
    }()
    
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    
    func configure(pinned: [MessagesDisplayData.Message]) {
        self.pinned = pinned
        self.backgroundColor = .systemBackground
    }
    
    // MARK: Private
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        addSubview(title)
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingTrailing).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topTitle).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.topCollection).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leadingTrailing).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.bottomCollection).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}


// MARK: -UICollectionViewDelegate

extension MessageHeader: UICollectionViewDelegate {
    
}


// MARK: -UICollectionViewDataSource

extension MessageHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pinned.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.forCellWithReuseIdentifier,
                                                            for: indexPath) as? MessageCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let message = pinned[indexPath.row]
        cell.configure(displayData: .init(image: message.image,
                                          username: message.firstName))
        return cell
    }
}
