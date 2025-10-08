//
//  Welcome.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import Foundation

// MARK: - Welcome
struct MoviesData: Codable {
    let movies: [Movie]
    
    init(movies: [Movie] = []) {
        self.movies = movies
    }
}

// MARK: - Movie
struct Movie: Codable,Identifiable {
    let id: Int
    let title: String?
    let releaseYear: Int?
    let rating: Double?
    let genres: [String]?
    let overview: String?
    
    public init(id: Int, title: String? = nil, releaseYear: Int? = nil, rating: Double? = nil, genres: [String]? = nil, overview: String? = nil) {
        self.id = id
        self.title = title
        self.releaseYear = releaseYear
        self.rating = rating
        self.genres = genres
        self.overview = overview
    }
}
