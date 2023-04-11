//
//  PopularMoviesViewModel.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation

class PopularMoviesViewModel: ObservableObject {
  @Published var movies: [Movie] = []
  
  private let movieDataSource: MovieDataSource
  private var isLoading = false
  private var currentPage = 1
  
  init(movieDataSource: MovieDataSource) {
    self.movieDataSource = movieDataSource
  }
  
  func fetchMovies() {
    currentPage = 1

    Task {
      do {
        let fetchedMovies = try await fetchPage(currentPage)
        await MainActor.run {
          movies = fetchedMovies
        }
      } catch {
        // handle the error in some way
      }
    }
  }
  
  func fetchNextpage() {
    currentPage += 1

    Task {
      do {
        let fetchedMovies = try await self.fetchPage(currentPage)
        await MainActor.run {
          movies += fetchedMovies
        }
      } catch {
        // handle the error in some way
      }
    }
  }
  
  private func fetchPage(_ page: Int) async throws -> [Movie] {
    guard isLoading == false else { return [] }

    isLoading = true
    defer { isLoading = false }
    
    // this used to return an empty array
    return try await movieDataSource.fetchMovies(page)
  }
}
