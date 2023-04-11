//
//  Synchronizer.swift
//  Chapter10
//
//  Created by Donny Wals on 20/03/2023.
//

import Foundation

class NewsItem {}

class Synchronizer {
  @Published var newsItems = [NewsItem]()
  var onComplete: () -> Void = {}
  
  func synchronize() {
    Task {
      try await Task.sleep(for: .seconds(0.5))
      newsItems = [NewsItem(), NewsItem()]
      onComplete()
    }
  }
}
