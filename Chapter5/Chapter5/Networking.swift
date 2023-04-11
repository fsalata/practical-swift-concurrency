//
//  Networking.swift
//  Chapter5
//
//  Created by Donny Wals on 05/04/2023.
//

import Foundation
import Combine

class Networking {
  func fetchHomepage() -> AnyPublisher<String, Error> {
    let url = URL(string: "https://practicalswiftconcurrency.com")!
    return URLSession.shared.dataTaskPublisher(for: url)
      .map { data, _ in
        return String(data: data, encoding: .utf8) ?? ""
      }
      .mapError({ $0 as Error })
      .eraseToAnyPublisher()
  }
  
  func fetchHomepage() async throws -> String {
    let asyncSequence = fetchHomepage().values
    
    for try await value in asyncSequence {
      return value
    }
    
    // we really shouldn't ever get here...
    return ""
  }
}
