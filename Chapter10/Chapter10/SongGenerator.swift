//
//  SongGenerator.swift
//  Chapter10
//
//  Created by Donny Wals on 15/03/2023.
//

import Foundation

struct Song {}

class SongGenerator {
    func generate(_ completion: @escaping (Result<Song, Error>) -> Void) {
        completion(.success(Song()))
    }
  
  func generate() async throws -> Song {
    return Song()
  }
}
