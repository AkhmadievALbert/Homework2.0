//
//  ChatTextField.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 13.10.2021.
//

import UIKit

final class ChatTextField: UITextField {
    
    // MARK: Private structures
    
    private struct Constants {
        static let textInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    
    // MARK: Public structures
    
    struct DisplayData {
        let button: UIButton
        let placeholder: String
    }
    
    // MARK: Public
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textInsets)
    }
    
    func configure(displayData: DisplayData) {
        rightViewMode = .always
        rightView = displayData.button
        placeholder = displayData.placeholder
    }
}
