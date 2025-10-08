//
//  FileEndPoints.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import Foundation

public enum FileEndPoints: String {
    
    case movieJson = "MovieJson"

    // MARK: - Helper
    public var fileURL: URL? {
        Bundle.main.url(forResource: self.rawValue, withExtension: "json")
    }
}
