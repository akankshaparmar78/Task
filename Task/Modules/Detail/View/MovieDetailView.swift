//
//  MovieDetailView.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var favoritesManager = FavoritesManager.shared
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(systemName: "film")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                HStack {
                    Text(movie.title ?? "Unknown Title")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(action: {
                        favoritesManager.toggle(movie)
                    }) {
                        Image(systemName: favoritesManager.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(favoritesManager.isFavorite(movie) ? .red : .gray)
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    if let year = movie.releaseYear {
                        Text("Released: \(year)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let rating = movie.rating {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f / 10", rating))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                
                if let genres = movie.genres {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                if let overview = movie.overview {
                    Text(overview)
                        .font(.body)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(movie.title ?? "Movie Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movie: Movie(
        id: 1,
        title: "Inception",
        releaseYear: 2010,
        rating: 8.8,
        genres: ["Action", "Sci-Fi"],
        overview: "A thief who steals corporate secrets through dreams."
    ))
}
