//
//  SearchView.swift
//  Task
//
//  Created by apple on 08/10/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            HStack {
                SearchBar(text: $viewModel.searchText) {
                    viewModel.searchText = ""
                    dismiss()
                }
                .padding(.horizontal, 20)
                
                Button {
                    viewModel.isShowingFavoritesView.toggle()
                } label: {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                        .padding(.trailing)
                }
            }
            
            // MARK: - Content
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding(.top, 40)
                Spacer()
            } else if viewModel.isEmpty {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                        .padding(.bottom, 8)
                    
                    Text("No movies found")
                        .foregroundColor(.gray)
                }
                .padding(.top, 80)
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.groupedMovies, id: \.decade) { section in
                            Section(header: Text(section.decade)
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            ) {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(section.movies) { movie in
                                        MovieCell(movie: movie)
                                            .overlay(
                                                Button(action: {
                                                    FavoritesManager.shared.toggle(movie)
                                                }) {
                                                    Image(systemName: FavoritesManager.shared.isFavorite(movie) ? "heart.fill" : "heart")
                                                        .foregroundColor(FavoritesManager.shared.isFavorite(movie) ? .red : .gray)
                                                        .padding(6)
                                                },
                                                alignment: .topTrailing
                                            )
                                            .onTapGesture {
                                                viewModel.selectedMovie = movie
                                                viewModel.isShowingMovieDetailView.toggle()
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity,alignment: .top)
        .edgesIgnoringSafeArea(.bottom)
        .navigationDestination(isPresented: $viewModel.isShowingMovieDetailView) {
            if let movie = viewModel.selectedMovie {
                MovieDetailView(movie: movie)
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingFavoritesView) {
            FavoritesView()
        }
    }
}

#Preview {
    SearchView()
}
