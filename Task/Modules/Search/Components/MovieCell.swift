//
//  MovieCell.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct MovieCell: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
         
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.15))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    )
            }
            
            Text(movie.title ?? "Unknown Title")
                .font(.headline)
                .lineLimit(1)
            
            if let year = movie.releaseYear {
                Text("\(year)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            if let genres = movie.genres {
                HStack(spacing: 4) {
                    ForEach(genres.prefix(2), id: \.self) { genre in
                        Text(genre)
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieCell(movie: Movie(
        id: 1,
        title: "Inception",
        releaseYear: 2010,
        rating: 8.8,
        genres: ["Action", "Sci-Fi"],
        overview: "A thief who steals corporate secrets through dreams."
    ))
}


