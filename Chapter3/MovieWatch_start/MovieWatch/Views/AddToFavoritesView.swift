//
//  AddToFavoritesView.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct AddToFavoritesView: View {
  @Environment(\.movie) var movie
  @EnvironmentObject var favoritesProvider: FavoritesProvider
  
  var body: some View {
    Button(action: {
      if favoritesProvider.isFavorite(movie) {
        favoritesProvider.removeFavorite(movie)
      } else {
        favoritesProvider.addFavorite(movie)
      }
    }, label: {
      HStack(spacing: 0) {
        if favoritesProvider.isFavorite(movie) {
          Image(systemName: "star.fill")
          Text("added to favorites")
        } else {
          Image(systemName: "star")
          Text("add to favorites")
        }
        
        Spacer()
      }
    })
  }
}
