//
//  FavoritesView.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var manager = FavoritesManager.shared
    @State private var sortOption: FavoritesManager.SortOption = .title
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingMovieDetailView = false
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        List {
            ForEach(manager.favorites, id: \.id) { fav in
                FavoriteMovieRow(movie: fav) { movie in
                    selectedMovie = movie
                    isShowingMovieDetailView = true
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        manager.remove(fav.toMovie())
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(Color.white)
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Sort by Title") { manager.sort(by: .title) }
                    Button("Sort by Release Year") { manager.sort(by: .releaseYear) }
                    Button("Sort by Rating") { manager.sort(by: .rating) }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationDestination(isPresented: $isShowingMovieDetailView) {
            if let movie = selectedMovie {
                MovieDetailView(movie: movie)
            }
        }
    }
}


extension FavoriteMovie {
    func toMovie() -> Movie {
        var genreArray: [String]? = nil
        if let genres = self.genres,
           let data = Data(base64Encoded: genres),
           let decoded = try? JSONDecoder().decode([String].self, from: data) {
            genreArray = decoded
        }
        return Movie(
            id: Int(id),
            title: title,
            releaseYear: Int(releaseYear),
            rating: rating,
            genres: genreArray,
            overview: overview
        )
    }
}

// MARK: - Preview
#Preview {
    FavoritesView()
}
