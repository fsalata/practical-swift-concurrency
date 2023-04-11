//
//  MoviesListView.swift
//  MovieWatch
//
//  Created by Donny Wals on 06/07/2022.
//

import Foundation
import SwiftUI

struct MoviesListView: View {
  @StateObject var moviesViewModel = PopularMoviesViewModel(movieDataSource: .init())
  @Environment(\.favoritesProvider) var favoritesProvider
  
  var body: some View {
    NavigationView {
      List(moviesViewModel.movies) { movie in
        NavigationLink(destination: {
          MovieView(movie: movie)
        }, label: {
          MovieCell(movieViewModel: .init(movie: movie,
                                          favoritesProvider: favoritesProvider))
          .onAppear {
            if movie == moviesViewModel.movies.last {
              moviesViewModel.fetchNextpage()
            }
          }
        })
      }
      .onAppear {
        moviesViewModel.fetchMovies()
      }
      .navigationTitle("Popular")
      .listStyle(.plain)
    }
  }
}
