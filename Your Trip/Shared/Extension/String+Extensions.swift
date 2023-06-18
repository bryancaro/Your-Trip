//
//  String+Extensions.swift
//  Your Trip
//
//  Created for Your Trip in 2023
//  Using Swift 5.0
//  Running on macOS 13.4
//
//  Created by Bryan Caro on 18/6/23.
//  
//

import Foundation

extension String {
    func formatDate() -> String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        guard let date = dateFormatterInput.date(from: self) else {
            return nil
        }
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMM d, yyyy"
        return dateFormatterOutput.string(from: date)
    }
}
