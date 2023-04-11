//
//  CrewMember.swift
//  Chapter9
//
//  Created by Donny Wals on 21/03/2023.
//

import Foundation

struct CrewMember: Decodable, Identifiable, Hashable {
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
  let creditId: String
  let department: String
  let job: String
}

extension CrewMember: Person {
  var role: String { department }
}
