//
//  Movie.swift
//  Chapter9
//
//  Created by Donny Wals on 21/03/2023.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
  let backdropPath: String?
  let id: Int
  let originalLanguage: String
  let originalTitle: String
  let overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate: String
  let title: String
  let video: Bool
  let voteAverage: Double
  let voteCount: Int
  
  var posterURL: URL? {
    guard let posterPath = posterPath else {
      return nil
    }
    
    return URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
  }
  
  var backdropURL: URL? {
    guard let backdropPath = backdropPath else {
      return nil
    }
    
    return URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")
  }
}

extension Movie {
  static let mock: Movie = .init(backdropPath: "/lXhgCODAbBXL5buk9yEmTpOoOgR.jpg", id: 122, originalLanguage: "en", originalTitle: "The Lord of the Rings: The Return of the King", overview: "Aragorn is revealed as the heir to the ancient kings as he, Gandalf and the other members of the broken fellowship struggle to save Gondor from Sauron's forces. Meanwhile, Frodo and Sam take the ring closer to the heart of Mordor, the dark lord's realm.", popularity: 104.659, posterPath: "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg", releaseDate: "2003-12-01", title: "The Lord of the Rings: The Return of the King", video: false, voteAverage: 8.5, voteCount: 19730)
}
