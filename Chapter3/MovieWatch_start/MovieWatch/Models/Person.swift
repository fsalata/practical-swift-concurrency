//
//  Person.swift
//  MovieWatch
//
//  Created by Donny Wals on 05/07/2022.
//

import Foundation

protocol Person {
  var name: String { get }
  var role: String { get }
  var profilePath: String? { get }
  var profileURL: URL? { get }
}

extension Person {
  var profileURL: URL? {
    guard let profilePath = profilePath else {
      return nil
    }
    
    return URL(string: "https://image.tmdb.org/t/p/w185\(profilePath)")
  }
}
