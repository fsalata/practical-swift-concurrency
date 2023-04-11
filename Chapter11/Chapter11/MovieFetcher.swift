//
//  MovieFetcher.swift
//  Chapter11
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation

typealias EnrichedMovie = (Movie, [CrewMember], [CastMember])

actor MovieFetcher {
  var fetchedMovies = [EnrichedMovie]()
  
  nonisolated func fetchCrewMembersFor(_ movie: Movie) async throws -> [CrewMember] {
    let url = URL(string: "http://127.0.0.1:8080/crew-\(movie.id).json")!
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    return try decoder.decode([CrewMember].self, from: data)
  }
  
  nonisolated func fetchCastMembersFor(_ movie: Movie) async throws -> [CastMember] {
    let url = URL(string: "http://127.0.0.1:8080/cast-\(movie.id).json")!
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    return try decoder.decode([CastMember].self, from: data)
  }
  
  nonisolated func fetchMovies(page: Int = 1) async throws -> [Movie] {
    let url = URL(string: "http://127.0.0.1:8080/\(page).json")!
    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    return try decoder.decode([Movie].self, from: data)
  }
  
  nonisolated func fetchDetailsFor(_ movie: Movie) async throws -> EnrichedMovie {
    async let crewMembersTask = fetchCrewMembersFor(movie)
    async let castMembersTask = fetchCastMembersFor(movie)
    
    let crew = try await crewMembersTask
    let cast = try await castMembersTask
    
    return (movie, crew, cast)
  }
  
  func fetchEnrichedMovies(page: Int) async throws {
    let movies = try await fetchMovies(page: page)
    
    let enrichedMovies = await withThrowingTaskGroup(of: EnrichedMovie.self) { group in
      for movie in movies {
        group.addTask(operation: {
          return try await self.fetchDetailsFor(movie)
        })
      }
      
      var results = [EnrichedMovie]()
      while let result = await group.nextResult() {
        if let info = try? result.get() {
          results.append(info)
        }
      }
      return results
    }
    
    fetchedMovies += enrichedMovies
  }
}
