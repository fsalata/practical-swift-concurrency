//
//  CastMember.swift
//  Chapter9
//
//  Created by Donny Wals on 21/03/2023.
//

import Foundation

struct CastMember: Codable, Identifiable, Hashable {
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
