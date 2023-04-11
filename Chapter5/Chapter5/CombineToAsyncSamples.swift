//
//  CombineToAsyncSamples.swift
//  Chapter5
//
//  Created by Donny Wals on 05/04/2023.
//

import Foundation
import Combine

class CombineToAsync {
  private let network = Networking()
  private var cancellables = Set<AnyCancellable>()
  
  func fetchHomePage() {
    network.fetchHomepage()
      .sink(receiveCompletion: { completion in
        print(completion)
      }, receiveValue: { htmlContent in
        print(htmlContent)
      })
      .store(in: &cancellables)
  }
  
  func fetchHomePageAsync() {
    Task {
      do {
        let homePage = try await network.fetchHomepage()
        print(homePage)
      } catch {
        print("something went wrong...")
      }
    }
  }
}
