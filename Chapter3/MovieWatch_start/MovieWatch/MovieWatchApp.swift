//
//  MovieWatchApp.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/07/2022.
//

import SwiftUI

@main
struct MovieWatchApp: App {
  let movieDataSource = MovieDataSource()
  let favoritesProvider = FavoritesProvider()
  
  var body: some Scene {
    WindowGroup {
      MainView()
        .environmentObject(PopularMoviesViewModel(movieDataSource: movieDataSource))
        .environmentObject(favoritesProvider)
        .environment(\.movieDataSource, movieDataSource)
        .environment(\.favoritesProvider, favoritesProvider)
    }
  }
}

struct MovieDataSourceKey: EnvironmentKey {
  static let defaultValue: MovieDataSource = {
    return MovieDataSource()
  }()
}

struct FavoritesProviderKey: EnvironmentKey {
  static let defaultValue: FavoritesProvider = {
    return FavoritesProvider()
  }()
}

struct MovieKey: EnvironmentKey {
  static let defaultValue: Movie = {
    return Movie.mock
  }()
}

extension EnvironmentValues {
  var movieDataSource: MovieDataSource {
    get { self[MovieDataSourceKey.self] }
    set { self[MovieDataSourceKey.self] = newValue }
  }
  
  var favoritesProvider: FavoritesProvider {
    get { self[FavoritesProviderKey.self] }
    set { self[FavoritesProviderKey.self] = newValue }
  }
  
  var movie: Movie {
    get { self[MovieKey.self] }
    set { self[MovieKey.self] = newValue }
  }
}
