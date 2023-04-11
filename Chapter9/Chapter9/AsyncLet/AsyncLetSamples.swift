//
//  AsyncLetSamples.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation

struct AsyncLetSamples {
  let datasource = MovieDataSource()
  
  func fetchDetailsFor_serial(_ movie: Movie) async throws -> ([CrewMember], [CastMember]) {
    let crew = try await fetchCrewMembersFor(movie)
    let cast = try await fetchCastMembersFor(movie)
    
    return (crew, cast)
  }
  
  func fetchDetailsFor_unstructured(_ movie: Movie) async throws -> ([CrewMember], [CastMember]) {
    let crewMembersTask = Task {
        return try await fetchCrewMembersFor(movie)
      }

      let castMembersTask = Task {
        return try await fetchCastMembersFor(movie)
      }
      
      let crew = try await crewMembersTask.value
      let cast = try await castMembersTask.value
      
      return (crew, cast)
  }
  
  func fetchDetailsFor(_ movie: Movie) async throws -> ([CrewMember], [CastMember]) {
    async let crewMembersTask = fetchCrewMembersFor(movie)
    async let castMembersTask = fetchCastMembersFor(movie)
    
    let crew = try await crewMembersTask
    let cast = try await castMembersTask
    
    return (crew, cast)
  }
  
  func fetchCastMembersFor(_ movie: Movie) async throws -> [CastMember] {
    return try await datasource.fetchCastMembersFor(movie)
  }
  
  func fetchCrewMembersFor(_ movie: Movie) async throws -> [CrewMember] {
    return try await datasource.fetchCrewMembersFor(movie)
  }
}
