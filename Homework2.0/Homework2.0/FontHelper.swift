//
//  FontHelper.swift
//  HomeWork2
//
//  Created by a.akhmadiev on 03.10.2021.
//

import UIKit

struct FontHelper {
    static var habibiFont: UIFont {
        get {
            guard let customFont = UIFont(name: "Habibi-Regular", size: UIFont.labelFontSize) else {
                fatalError("""
                    Failed to load the "CustomFont-Light" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
                )
            }
            return customFont
        }
    }
}
