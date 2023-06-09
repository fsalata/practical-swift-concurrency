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
				let movies = try await movieDataSource.fetchMovies(currentPage)
				await MainActor.run {
					self.movies = movies
				}
			}
			catch {
				print(error)
			}
		}
  }
  
  func fetchNextpage() {
    currentPage += 1

		Task {
			do {
				let movies = try await movieDataSource.fetchMovies(currentPage)
				await MainActor.run {
					self.movies += movies
				}
			}
			catch {
				print(error)
			}
		}
  }
  
  private func fetchPage(_ page: Int) async throws -> [Movie] {
    guard isLoading == false else { return [] }
    
    isLoading = true
    defer { isLoading = false }
    
    return []
  }
}
