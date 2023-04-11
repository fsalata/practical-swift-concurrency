//
//  FavoritesView.swift
//  MovieWatch
//
//  Created by Donny Wals on 06/07/2022.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
  @EnvironmentObject var favoritesProvider: FavoritesProvider
  
  var body: some View {
    NavigationView {
      List(Array(favoritesProvider.favorites)) { movie in
        NavigationLink(destination: {
          MovieView(movie: movie)
        }, label: {
          MovieCell(movieViewModel: .init(movie: movie,
                                          favoritesProvider: favoritesProvider))
        })
      }
      .navigationTitle("Favorites")
      .listStyle(.plain)
    }
  }
}
