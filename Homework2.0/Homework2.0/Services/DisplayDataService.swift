//
//  DisplayDataService.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 06.10.2021.
//

import UIKit

protocol DisplayDataServiceProtocol {
    func displayDataForProfileView(completion: @escaping (Result<ProfileDisplayData, Error>) -> Void)
}

final class DisplayDataService: DisplayDataServiceProtocol {
    
    // MARK: Static properties
    
    static let `default`: DisplayDataServiceProtocol = DisplayDataService()
    
    
    
    // MARK: Public
    
    func displayDataForProfileView(completion: @escaping (Result<ProfileDisplayData, Error>) -> Void) {
        completion(.success(ProfileDisplayData(username: "Alex Tsimikas",
                                               city: "Brooklyn, NY")))
    }
}

