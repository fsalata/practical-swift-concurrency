//
//  MovieDataSource.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/07/2022.
//

import Foundation

class MovieDataSource {
	func fetchMovies(_ page: Int) async throws -> [Movie] {
		let url = URL(string: "http://127.0.0.1:8080/\(page).json")!
		let (data, _) = try await URLSession.shared.data(from: url)

		let movies = try JSONDecoder().decode([Movie].self, from: data)
		return movies
	}

	func fetchCastMembers(for movieID: Int) async throws -> [CastMember] {
		let url = URL(string: "http://127.0.0.1:8080/cast-\(movieID).json")!
		let (data, _) = try await URLSession.shared.data(from: url)

		let movies = try JSONDecoder().decode([CastMember].self, from: data)
		return movies
	}

	func fetchCrewMembers(for movieID: Int) async throws -> [CrewMember] {
		let url = URL(string: "http://127.0.0.1:8080/crew-\(movieID).json")!
		let (data, _) = try await URLSession.shared.data(from: url)

		let movies = try JSONDecoder().decode([CrewMember].self, from: data)
		return movies
	}
}
