//
//  ProfileViewController.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: Private structors
    
    private struct Constants {
        static let buttonTop: CGFloat = 101
        static let cityLabelTop: CGFloat = 19
        static let buttonInsets: CGFloat = 9.5
        static let cityLabelLeading: CGFloat = 25
        static let buttonBorderWidth: CGFloat = 1
        static let buttonCornerRadius: CGFloat = 15
        static let buttonBorderInsets: CGFloat = 40
        static let buttonTopBottomInsets: CGFloat = 6
    }
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: FontHelper.habibiFont)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.borderWidth = Constants.buttonBorderWidth
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = .init(top: 0, left: -Constants.buttonInsets, bottom: 0, right: Constants.buttonInsets)
        button.titleEdgeInsets = .init(top: 0, left: Constants.buttonInsets, bottom: 0, right: -Constants.buttonInsets)
        button.contentEdgeInsets = .init(top: Constants.buttonTopBottomInsets,
                                         left: Constants.buttonBorderInsets,
                                         bottom: Constants.buttonTopBottomInsets,
                                         right: Constants.buttonBorderInsets)
        
        button.setImage(ImageHelper.arrowBack?.withTintColor(.label), for: .normal)
        button.setTitle(Localizable.profileLogoutButton, for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        button.titleLabel?.font = UIFontMetrics(forTextStyle: .title3).scaledFont(for: FontHelper.habibiFont)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return button
    }()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    
    // MARK: Public
    
    func configure() {
        DisplayDataService.default.displayDataForProfileView { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let displayData):
                self.navigationItem.title = displayData.username
                self.cityLabel.text = displayData.city
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Private
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = .init(title: Localizable.profilePageMessageButton,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(messagesTaped))
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)], for: .normal)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFontMetrics(forTextStyle: .body).scaledFont(for: FontHelper.habibiFont)], for: .highlighted)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(cityLabel)
        cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.cityLabelLeading).isActive = true
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.cityLabelTop).isActive = true
        
        view.addSubview(logoutButton)
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Constants.buttonTop).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutTaped), for: .touchUpInside)
    }
    
    @objc private func messagesTaped() {
        // TODO: In feature/Messages
    }
    
    @objc private func logoutTaped() {
        // logout action logic
    }
}
