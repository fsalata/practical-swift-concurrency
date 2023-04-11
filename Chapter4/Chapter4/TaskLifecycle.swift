//
//  TaskLifecycle.swift
//  Chapter4
//
//  Created by Donny Wals on 02/04/2023.
//

import Foundation

struct Response {
  let hasMorePages: Bool
}

class Networking {
  func fetchPage(_ page: Int) async -> Response {
    return Response(hasMorePages: page == 10)
  }
}

class TaskLifecycle {
  let networking = Networking()
  var items = [Response]()
  
  func loadAllPages() {
    Task {
      var hasMorePages = true
      var currentPage = 0
      
      while hasMorePages {
        let page = await networking.fetchPage(currentPage)
        if page.hasMorePages {
          currentPage += 1
          items.append(page)
        } else {
          hasMorePages = false
        }
      }
    }
  }
  
  func loadAllPages2() {
      // we've added a weak self here
      Task { [weak self] in
        var hasMorePages = true
        var currentPage = 0

        while hasMorePages  {
          guard let self = self else {
            return
          }
                  
          let page = await self.networking.fetchPage(currentPage)
          if page.hasMorePages {
            currentPage += 1
            self.items.append(page)
          } else {
            hasMorePages = false
          }
        }
      }
    }
}
