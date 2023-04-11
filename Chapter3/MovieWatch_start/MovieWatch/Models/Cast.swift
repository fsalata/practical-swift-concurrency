//
//  Cast.swift
//  MovieWatch
//
//  Created by Donny Wals on 05/07/2022.
//

import Foundation

struct CastMember: Codable, Identifiable {
  var uniqueId: String {
    UUID().uuidString
  }
  
  let adult: Bool
  let gender: Int?
  let id: Int
  let knownForDepartment: String
  let name: String
  let originalName: String
  let popularity: Double
  let profilePath: String?
  let castId: Int
  let character: String?
  let creditId: String
  let order: Int
}

extension CastMember: Person {
  var role: String { character ?? name }
}
