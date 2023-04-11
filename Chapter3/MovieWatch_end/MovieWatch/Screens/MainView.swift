//
//  MainView.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/07/2022.
//

import Foundation
import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      MoviesListView()
        .tabItem({
          VStack {
            Image(systemName: "film")
            Text("Popular")
          }
        })
      
      FavoritesView()
        .tabItem({
          VStack {
            Image(systemName: "star")
            Text("Favorites")
          }
        })
    }
  }
}
