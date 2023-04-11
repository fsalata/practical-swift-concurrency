//
//  DispatchGroups.swift
//  Chapter2
//
//  Created by Donny Wals on 31/03/2023.
//

import Foundation

func fetchWebsites() {
  let group = DispatchGroup() // 1
  var results = [Data]()
  let urls = [
    "https://practicalcoredata.com",
    "https://practicalcombine.com",
    "https://practicalswiftconcurrency.com"
  ].compactMap(URL.init)

  for url in urls {
    group.enter() // 3

    URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data {
        results.append(data)
      }
      group.leave() // 4
    }.resume()
  }
  
  // 2
  group.notify(queue: DispatchQueue.main) {
    print(results)
  }
}
