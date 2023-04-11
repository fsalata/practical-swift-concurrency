//
//  SearchFeature.swift
//  Chapter5
//
//  Created by Donny Wals on 05/04/2023.
//

import Foundation
import Combine

class SearchFeature: ObservableObject {
  @Published var searchText = ""
  @Published var results: [String] = []
    
  init() {
    // pure Combine version of the search feature
//    $searchText
//      .debounce(for: 0.3, scheduler: DispatchQueue.main)
//      .flatMap { query in
//        let url = URL(string: "https://practicalswiftconcurrency.com?q=\(query)")!
//        return URLSession.shared.dataTaskPublisher(for: url)
//          .map(\.data)
//          .decode(type: [String].self, decoder: JSONDecoder())
//          .replaceError(with: ["Combine, \(query)"])
//      }
//      .receive(on: DispatchQueue.main)
//      .assign(to: &$results)
    
    // Combine + async/await mixed version of the search feature
    $searchText
      .debounce(for: 0.3, scheduler: DispatchQueue.main)
      .flatMap { query in
        return Future { [weak self] promise in
          guard let self = self else {
            promise(.success([]))
            return
          }
          
          Task {
            do {
              let results = try await self.search(for: query)
              promise(.success(results))
            } catch {
              // instead of failing, complete with empty result
              promise(.success(["Combine + async/await, \(query)"]))
            }
          }
        }
      }
      .receive(on: DispatchQueue.main)
      .assign(to: &$results)
  }
  
  func search(for query: String) async throws -> [String] {
    let url = URL(string: "https://practicalswiftconcurrency.com?q=\(query)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([String].self, from: data)
  }
}
