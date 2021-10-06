//
//  MessagesDisplayData.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

struct MessagesDisplayData {
    
    let messages: [Message]
    
    struct Message {
        let image: UIImage?
        let firstName: String
        let lastName: String
        let description: String
        let date: String
    }
}
