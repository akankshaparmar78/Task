//
//  SearchViewModel.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    
    // MARK: - Published States
    @Published var isLoading = false
    @Published var alertMessage = ""
    @Published var moviesList: [Movie] = []
    @Published var groupedMovies: [(decade: String, movies: [Movie])] = []
    @Published var searchText: String = ""
    @Published var isEmpty = false
    @Published var isShowingMovieDetailView = false
    @Published var isShowingFavoritesView = false
    @Published var selectedMovie: Movie?
    
    private var allMovies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    private let service: MovieServiceProtocol
    
    // Init
    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
        setupSearchBinding()
        Task { await fetchSearchResults() }
    }
    
    // Fetch Data
    func fetchSearchResults() async {
        isLoading = true
        do {
            let data = try await service.getAllMovies()
            allMovies = data.movies
            groupMovies(allMovies)
        } catch {
            alertMessage = "Failed to load movies: \(error.localizedDescription)"
            isEmpty = true
        }
        isLoading = false
    }
    
    // Search
    private func setupSearchBinding() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterMovies(query: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterMovies(query: String) {
        if query.isEmpty {
            groupMovies(allMovies)
        } else {
            let filtered = allMovies.filter {
                $0.title?.localizedCaseInsensitiveContains(query) ?? false
            }
            groupMovies(filtered)
        }
    }
    
    // Group by Decade
    private func groupMovies(_ movies: [Movie]) {
        let grouped = Dictionary(grouping: movies) { movie -> String in
            guard let year = movie.releaseYear else { return "Unknown" }
            let decadeStart = (year / 10) * 10
            return "\(decadeStart)s"
        }
        .sorted(by: { $0.key < $1.key })
        
        groupedMovies = grouped.map { (decade: $0.key, movies: $0.value) }
        isEmpty = groupedMovies.isEmpty
    }
}
