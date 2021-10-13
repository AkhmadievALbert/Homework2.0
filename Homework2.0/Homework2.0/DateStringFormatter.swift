//
//  DateStringFormatter.swift
//  Homework2.0
//
//  Created by a.akhmadiev on 13.10.2021.
//

import Foundation

final class DareStringFormatter {
    
    static func timeInString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        
        return formatter.string(from: date)
    }
    
    static func dayAndMothToString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter.string(from: date)
    }
}
