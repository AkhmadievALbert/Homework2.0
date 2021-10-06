//
//  DisplayDataService.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

protocol DisplayDataServiceProtocol {
    func displayDataForProfileView(completion: @escaping (Result<ProfileDisplayData, Error>) -> Void)
    func displayDataForMessagesView(completion: @escaping (Result<MessagesDisplayData, Error>) -> Void)
}

final class DisplayDataService: DisplayDataServiceProtocol {
    
    // MARK: Static properties
    
    static let `default`: DisplayDataServiceProtocol = DisplayDataService()
    
    // MARK: Private
    
    private let messages: [MessagesDisplayData.Message] = [.init(image: UIImage(named: "ProfilePhoto-1"), firstName: "Jessica", lastName: "Thompson", description: "Hey you! Are u there?", date: "4h ago"),
                                                           .init(image: UIImage(named: "ProfilePhoto-2"), firstName: "Kat", lastName: "Williams", description: "OMG! OMG! OMG!", date: "5h ago"),
                                                           .init(image: UIImage(named: "ProfilePhoto-3"), firstName: "Jacob", lastName: "Washington", description: "Sure. Sunday works for me!", date: "20/9/21"),
                                                           .init(image: nil, firstName: "Leslie", lastName: "Alexander", description: "Sent you an invite for next monday.", date: "19/9/21"),
                                                           .init(image: UIImage(named: "ProfilePhoto-4"), firstName: "Tony", lastName: "Monta", description: "How’s Alicia doing? Ask her to give m...", date: "19/9/21")]
    
    // MARK: Public
    
    func displayDataForProfileView(completion: @escaping (Result<ProfileDisplayData, Error>) -> Void) {
        completion(.success(ProfileDisplayData(username: "Alex Tsimikas",
                                               city: "Brooklyn, NY")))
    }
    
    func displayDataForMessagesView(completion: @escaping (Result<MessagesDisplayData, Error>) -> Void) {
        completion(.success(MessagesDisplayData(messages: messages)))
    }
}

