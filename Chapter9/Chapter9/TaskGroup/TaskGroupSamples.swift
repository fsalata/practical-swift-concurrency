//
//  TaskGroupSamples.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation

struct TaskGroupSamples {
  let datasource = MovieDataSource()
  
  func fetchEnrichedMovies_usingResult() async throws -> [Result<(Movie, [CrewMember], [CastMember]), any Error>] {
    let movies = try await fetchMovies()
    
    let moviesWithDetails = await withThrowingTaskGroup(of: (Movie, [CrewMember], [CastMember]).self) { group in
      for movie in movies {
        group.addTask(operation: {
          return try await self.fetchDetailsFor(movie)
        })
      }

      var results = [Result<(Movie, [CrewMember], [CastMember]), Error>]()
          
      while let result = await group.nextResult() {
        results.append(result)
      }
          
      return results
    }
    
    return moviesWithDetails
  }
  
  func fetchEnrichedMovies_unhandledErrors() async throws -> [(Movie, [CrewMember], [CastMember])] {
    let movies = try await fetchMovies()
    
    let moviesWithDetails = try await withThrowingTaskGroup(of: (Movie, [CrewMember], [CastMember]).self) { group in
      for movie in movies {
        group.addTask(operation: {
          return try await self.fetchDetailsFor(movie)
        })
      }

      var results = [(Movie, [CrewMember], [CastMember])]()

      for try await result in group {
        results.append(result)
      }

      return results
    }
    
    return moviesWithDetails
  }

  func taskGroupWithIntReturnType() async {
    let list = [1, 2, 4, 5]
    let randomNumber = await withThrowingTaskGroup(of: Void.self) { group in
      for _ in list {
        group.addTask {
          try await Task.sleep(for: .seconds(2))
        }
      }
      
      let int = Int.random(in: 0..<Int.max)
      print("will return", int)
      return int
    }

    print("number is", randomNumber)
  }
  
  func fetchEnrichedMovies_taskgroup1() async throws -> [(Movie, [CrewMember], [CastMember])] {
    let movies = try await fetchMovies()
    
    await withThrowingTaskGroup(of: (Movie, [CrewMember], [CastMember]).self) { group in
      for movie in movies {
        group.addTask(operation: {
          return try await self.fetchDetailsFor(movie)
        })
      }
    }
    
    return []
  }
  
  func fetchEnrichedMovies_serial() async throws -> [(Movie, [CrewMember], [CastMember])] {
    let movies = try await fetchMovies()
    var enrichedMovies = [(Movie, [CrewMember], [CastMember])]()
    
    for movie in movies {
      let enriched = try await fetchDetailsFor(movie)
      enrichedMovies.append(enriched)
    }

    return enrichedMovies
  }
  
  func fetchDetailsFor(_ movie: Movie) async throws -> (Movie, [CrewMember], [CastMember]) {
    async let crewMembersTask = fetchCrewMembersFor(movie)
    async let castMembersTask = fetchCastMembersFor(movie)
    
    let crew = try await crewMembersTask
    let cast = try await castMembersTask
    
    return (movie, crew, cast)
  }
  
  func fetchMovies(page: Int = 1) async throws -> [Movie] {
    return try await datasource.fetchMovies()
  }
  
  func fetchCastMembersFor(_ movie: Movie) async throws -> [CastMember] {
    return try await datasource.fetchCastMembersFor(movie)
  }
  
  func fetchCrewMembersFor(_ movie: Movie) async throws -> [CrewMember] {
    return try await datasource.fetchCrewMembersFor(movie)
  }
}
