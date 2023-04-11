//
//  MovieDataSource.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation

class MovieDataSource {
  func fetchCrewMembersFor(_ movie: Movie) async throws -> [CrewMember] {
    let url = URL(string: "http://127.0.0.1:8080/crew-\(movie.id).json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    return try decoder.decode([CrewMember].self, from: data)
  }
  
  func fetchCastMembersFor(_ movie: Movie) async throws -> [CastMember] {
    let url = URL(string: "http://127.0.0.1:8080/cast-\(movie.id).json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    return try decoder.decode([CastMember].self, from: data)
  }
  
  func fetchMovies(page: Int = 1) async throws -> [Movie] {
    let url = URL(string: "http://127.0.0.1:8080/\(page).json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    return try decoder.decode([Movie].self, from: data)
  }
}
