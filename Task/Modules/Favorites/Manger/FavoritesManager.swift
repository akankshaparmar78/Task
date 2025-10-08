//
//  FavoritesManager.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI
import Combine
import CoreData

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    let container: NSPersistentContainer
    @Published var favorites: [FavoriteMovie] = []
    
    private init() {
        container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data: \(error)")
            }
        }
        fetchFavorites()
    }
    
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            favorites = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching favorites: \(error)")
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains { $0.id == movie.id }
    }
    
    func add(_ movie: Movie) {
        guard !isFavorite(movie) else { return }
        let fav = FavoriteMovie(context: container.viewContext)
        fav.id = Int64(movie.id)
        fav.title = movie.title
        fav.releaseYear = Int16(movie.releaseYear ?? 0)
        fav.rating = movie.rating ?? 0
        fav.overview = movie.overview
        if let genres = movie.genres {
            fav.genres = try? JSONEncoder().encode(genres).base64EncodedString()
        }
        save()
    }
    
    func remove(_ movie: Movie) {
        if let fav = favorites.first(where: { $0.id == movie.id }) {
            container.viewContext.delete(fav)
            save()
        }
    }
    
    func toggle(_ movie: Movie) {
        isFavorite(movie) ? remove(movie) : add(movie)
    }
    
    func sort(by option: SortOption) {
        switch option {
        case .title:
            favorites.sort { ($0.title ?? "") < ($1.title ?? "") }
        case .releaseYear:
            favorites.sort { ($0.releaseYear) < ($1.releaseYear) }
        case .rating:
            favorites.sort { ($0.rating) > ($1.rating) }
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
            fetchFavorites()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }
    
    enum SortOption {
        case title, releaseYear, rating
    }
}
