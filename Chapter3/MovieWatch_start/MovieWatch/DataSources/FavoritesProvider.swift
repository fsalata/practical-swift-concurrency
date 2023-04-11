//
//  FavoritesProvider.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/01/2023.
//

import Foundation

class FavoritesProvider: ObservableObject {
  @Published private(set) var favorites: Set<Movie> = []
  
  func isFavorite(_ movie: Movie) -> Bool {
    return favorites.contains(movie)
  }
  
  func addFavorite(_ movie: Movie) {
    favorites.insert(movie)
  }
  
  func removeFavorite(_ movie: Movie) {
    favorites.remove(movie)
  }
}
