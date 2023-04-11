//
//  MovieViewModel.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation

class MovieViewModel: ObservableObject {
  let movie: Movie
  @Published var isFavorite = false
  
  init(movie: Movie, favoritesProvider: FavoritesProvider) {
    self.movie = movie
    
    favoritesProvider.$favorites
      .map { newFavorites in
        return newFavorites.contains(movie)
      }
      .removeDuplicates()
      .assign(to: &$isFavorite)
  }
}
