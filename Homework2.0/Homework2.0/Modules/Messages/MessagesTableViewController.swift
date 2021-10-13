//
//  MessagesViewController.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

final class MessagesTableViewController: UIViewController {
    
    // MARK: Private structures
    
    private struct Constants {
        static let leadingTrailing: CGFloat = 8
        static let collectionHeight: CGFloat = 142
        static let collectionItemWidth: CGFloat = 80
        static let collectionItemHeight: CGFloat = 108
        static let forCellReuseIdentifier = "MessageCell"
        static let forHeaderFooterViewReuseIdentifier = "MessageHeader"
    }
    
    // MARK: Private properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: Constants.forCellReuseIdentifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var tableMessages: [MessagesDisplayData.Message] = []
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension

        setupNavbar()
        setupView()
    }
    
    
    // MARK: Public
    
    func configure() {
        DisplayDataService.default.displayDataForMessagesView { [weak self] displayData in
            guard let self = self else { return }
            
            self.tableMessages = displayData.messages
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.layoutIfNeeded()
    }
    
    private func setupNavbar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Localizable.messagesTitle
        navigationItem.backButtonTitle = ""
        searchController.obscuresBackgroundDuringPresentation = false
        let searchPlaceholderMutableString = NSMutableAttributedString(string: Localizable.messagesSearchPlaceholder,
                                                                       attributes: [NSAttributedString.Key.font : UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont),
                                                                                    .foregroundColor: ColorHelper.messageDescriptionColor])
        searchController.searchBar.searchTextField.attributedPlaceholder = searchPlaceholderMutableString
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}


// MARK: -UITableViewDelegate

extension MessagesTableViewController: UITableViewDelegate {
    
}


// MARK: -UITableViewDataSource

extension MessagesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.forCellReuseIdentifier) as? MessageTableViewCell else {
            return UITableViewCell()
        }
        let message = tableMessages[indexPath.row]
        cell.configure(displayData: .init(image: message.image,
                                          username: "\(message.firstName) \(message.lastName)",
                                          description: message.description,
                                          date: message.date))
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let chatViewController = ChatViewController()
        chatViewController.configure()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}
