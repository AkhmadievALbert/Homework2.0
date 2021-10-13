//
//  ChatDisplayData.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 11.10.2021.
//

import Foundation

struct ChatDisplayData {

    let sectionsData: [ChatMessageSection]
    
    struct ChatMessage {
         let text: String
         let date: Date
         let isExternalMessage: Bool
     }

     struct ChatMessageSection {
         var messages: [ChatMessage]
         let date: Date
     }
}
