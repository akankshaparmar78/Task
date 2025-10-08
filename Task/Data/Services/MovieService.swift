//
//  MovieService.swift
//  Task
//
//  Created by apple on 08/10/25.
//


import Foundation

protocol MovieServiceProtocol {
    func getAllMovies() async throws -> MoviesData
}

final class MovieService: MovieServiceProtocol {
    
    private let jsonService: JsonServicesProtocol
    
    init(jsonService: JsonServicesProtocol = JsonServices()) {
        self.jsonService = jsonService
    }
    
    func getAllMovies() async throws -> MoviesData {
        try await jsonService.readData(endpoint: .movieJson, type: MoviesData.self)
    }
    
}
