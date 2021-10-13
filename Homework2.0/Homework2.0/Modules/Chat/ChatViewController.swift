//
//  ChatViewController.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 11.10.2021.
//

import UIKit

class ChatViewController: UIViewController {
    
    private var sectionsData: [ChatDisplayData.ChatMessageSection] = []
    
    // MARK: Private Data structures
    
    private enum Constants {
        static let lineHeight: CGFloat = 1
        static let cornerRadius: CGFloat = 20
        static let textViewHeight: CGFloat = 40
        static let placeholderBottom: CGFloat = 10
        static let textViewTopOffset: CGFloat = 12
        static let textViewLeadingOffset: CGFloat = 16
        static let textViewTrailingOffset: CGFloat = 16
        
        static let chatMessageTableViewCellIdentifier = "ChatMessageTableViewCell"
        static let chatHeaderViewIdentifier = "ChatHeaderView"
    }
    
    // MARK: Private properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChatMessageTableViewCell.self, forCellReuseIdentifier: Constants.chatMessageTableViewCellIdentifier)
        tableView.register(ChatHeaderView.self,forHeaderFooterViewReuseIdentifier: Constants.chatHeaderViewIdentifier)
        return tableView
    }()
    
    private let textField: ChatTextField = {
        let textField = ChatTextField()
        textField.backgroundColor = ColorHelper.imagePlaceholderColor
        textField.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)
        textField.adjustsFontForContentSizeCategory = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton(type: .custom)
        button.setImage(ImageHelper.sendImage, for: .normal)
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        textField.configure(displayData: ChatTextField.DisplayData(button: button,
                                                                   placeholder: Localizable.chatTextFieldPlaceholder))
        return textField
    }()
    
    private let topBorderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryLabel
        return view
    }()
    
    private let textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        setupNavbar()
        setupView()
    }
    
    // MARK: Public
    
    func configure() {
        DisplayDataService.default.displayDataForChatView { [weak self] displayData in
            guard let self = self else { return }
            self.sectionsData = displayData.sectionsData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Private
    
    private func setupView() {

        view.addSubview(textFieldView)
        textFieldView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(textFieldView.snp.top)
        }
        
        textFieldView.addSubview(topBorderView)
        topBorderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constants.lineHeight)
        }

        textFieldView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldView).offset(Constants.textViewTopOffset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constants.placeholderBottom)
            make.leading.equalTo(textFieldView).inset(Constants.textViewLeadingOffset)
            make.trailing.equalTo(textFieldView).inset(Constants.textViewTrailingOffset)
            make.height.equalTo(Constants.textViewHeight)
        }
    }

    private func setupNavbar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = Localizable.chatTitle
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, view.frame.origin.y == 0 {
            view.frame.origin.y -= keyboardSize.height - view.safeAreaInsets.bottom
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }

    @objc private func sendTapped() {
        if let text = textField.text, text != "" {
            textField.text = ""
            let message = ChatDisplayData.ChatMessage(text: text,
                                                      date: Date(),
                                                      isExternalMessage: false)
            sectionsData[sectionsData.count - 1].messages.append(message)
            tableView.reloadData()
        }

        self.tableView.reloadData()
        tableView.scrollToNearestSelectedRow(at: .bottom, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsData[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.chatMessageTableViewCellIdentifier) as? ChatMessageTableViewCell else {
            return UITableViewCell()
        }
        let message = sectionsData[indexPath.section].messages[indexPath.row]

        let image: UIImage? = message.isExternalMessage ? UIImage(named: "ProfilePhoto-2") : nil
        cell.configure(displayData: ChatMessageTableViewCell.DisplayData(isExternal: message.isExternalMessage,
                                                                         image: image,
                                                                         message: message.text,
                                                                         date: DareStringFormatter.timeInString(from: message.date)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.chatHeaderViewIdentifier) as? ChatHeaderView else {
            return UIView()
        }
        header.configure(dateString: DareStringFormatter.dayAndMothToString(from: sectionsData[section].date))
        return header
    }
}


// MARK: - UITextFieldDelegate

extension ChatViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, text != "" {
            let message = ChatDisplayData.ChatMessage(text: text,
                                                      date: Date(),
                                                      isExternalMessage: false)
            sectionsData[sectionsData.count - 1].messages.append(message)
            tableView.reloadData()
        }
        textField.resignFirstResponder()
        return true
    }
}
