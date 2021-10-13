//
//  DisplayDataService.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

protocol DisplayDataServiceProtocol {
    func displayDataForProfileView(completion: @escaping (ProfileDisplayData) -> Void)
    func displayDataForMessagesView(completion: @escaping (MessagesDisplayData) -> Void)
    func displayDataForChatView(completion: @escaping (ChatDisplayData) -> Void)
}

final class DisplayDataService: DisplayDataServiceProtocol {
    
    // MARK: Static properties
    
    static let `default`: DisplayDataServiceProtocol = DisplayDataService()
    
    // MARK: Private
    
    private let messages: [MessagesDisplayData.Message] = [.init(image: UIImage(named: "ProfilePhoto-1"), firstName: "Jessica", lastName: "Thompson",                                                              description: "Hey you! Are u there?", date: "4h ago"),
                                                           .init(image: UIImage(named: "ProfilePhoto-2"), firstName: "Kat", lastName: "Williams", description: "OMG! OMG! OMG!", date: "5h ago"),
                                                           .init(image: UIImage(named: "ProfilePhoto-3"), firstName: "Jacob", lastName: "Washington", description: "Sure. Sunday works for me!", date: "20/9/21"),
                                                           .init(image: nil, firstName: "Leslie", lastName: "Alexander", description: "Sent you an invite for next monday.", date: "19/9/21"),
                                                           .init(image: UIImage(named: "ProfilePhoto-4"), firstName: "Tony", lastName: "Monta", description: "How’s Alicia doing? Ask her to give m...", date: "19/9/21")]
    
    private let chatSectionData: [ChatDisplayData.ChatMessageSection] = [
        .init(messages: [.init(text: "Alba", date: .distantPast, isExternalMessage: false)],
              date: Date()),
        .init(messages: [.init(text: "Alba", date: .distantPast, isExternalMessage: true)],
              date: Date(timeIntervalSinceNow: -10000000)),
        .init(messages: [.init(text: "AlbaAlbaAlbaAlbaAlba", date: .distantPast, isExternalMessage: true)],
              date: Date(timeIntervalSinceNow: -10000000)),
        .init(messages: [.init(text: "Alba Alba Alba Alba Alba Alba Alba", date: .distantPast, isExternalMessage: false)],
              date: Date(timeIntervalSinceNow: -10000000)),
        .init(messages: [.init(text: "Alba", date: .distantPast, isExternalMessage: true)],
              date: Date(timeIntervalSinceNow: -10000000))
    ]
    
    // MARK: Public
    
    func displayDataForProfileView(completion: @escaping (ProfileDisplayData) -> Void) {
        completion(ProfileDisplayData(username: "Alex Tsimikas",
                                               city: "Brooklyn, NY"))
    }
    
    func displayDataForMessagesView(completion: @escaping (MessagesDisplayData) -> Void) {
        completion(MessagesDisplayData(messages: messages))
    }
    
    func displayDataForChatView(completion: @escaping (ChatDisplayData) -> Void) {
        completion(ChatDisplayData(sectionsData: chatSectionData))
    }
}

