//
//  JsonServises.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import Foundation

public protocol JsonServicesProtocol {
    func readData<T: Codable>(endpoint: FileEndPoints, type: T.Type) async throws -> T
}

public final class JsonServices: JsonServicesProtocol {
    public init() {}

    public func readData<T: Codable>(endpoint: FileEndPoints, type: T.Type) async throws -> T {
        guard let url = endpoint.fileURL else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
