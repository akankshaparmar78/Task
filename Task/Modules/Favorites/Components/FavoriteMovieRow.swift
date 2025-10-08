//
//  FavoriteMovieRow.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct FavoriteMovieRow: View {
    let movie: FavoriteMovie
    let onTap: (Movie) -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "film")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 90)
                .cornerRadius(8)
                .background(Color.gray.opacity(0.2))
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title ?? "")
                    .font(.headline)
                    .lineLimit(2)
                
                Text("Released: \(movie.releaseYear)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f / 10", movie.rating))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.1))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
        .onTapGesture {
            onTap(movie.toMovie())
        }
    }
}
