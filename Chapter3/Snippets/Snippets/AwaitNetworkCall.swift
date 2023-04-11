//
//  AwaitNetworkCall.swift
//  Snippets
//
//  Created by Donny Wals on 31/03/2023.
//

import Foundation

func awaitWithConcurrency() async {
  let url = URL(string: "https://practicalswiftconcurrency.com")!
  
  do {
    let (data, _) = try await URLSession.shared.data(from: url)
    let htmlBody = String(data: data, encoding: .utf8)!
    print(htmlBody)
  } catch {
    print(error)
  }
}

func awaitWithoutConcurrency() {
  let url = URL(string: "https://practicalswiftconcurrency.com")!
  
  URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
      print(error)
      return
    }
    
    guard let data = data else {
      return
    }
    
    let htmlBody = String(data: data, encoding: .utf8)!
    print(htmlBody)
  }.resume()
}

@MainActor
func loopWithYielding() async {
  let url = URL(string: "https://practicalswiftconcurrency.com")!
  
  // This example is a bad example of loading data from the network but it does a good job of demonstrating a long-running and blocking operation.
  for _ in 0..<100 {
    let data = try! Data(contentsOf: url)
    print(data.count)
    // Uncomment the line below and try clicking other buttons after running this function. You'll see that the UI is unresponsive. When you re-add the yield things are much smoother.
    await Task.yield()
  }
}
