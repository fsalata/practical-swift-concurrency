//
//  AdvancedTaskGroups.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation

extension TaskGroupSamples {
  func taskGroupWithLimit() async {
    await withTaskGroup(of: Void.self) { group in
      for idx in 0..<10 {
        if idx >= 3 {
          print("We're at the threshold. Waiting for a task to complete.")
          await group.next()
        }
        
        print("Adding a new task.")
        group.addTask {
          do {
            try await Task.sleep(for: .seconds(Int.random(in: 0..<3)))
          } catch {
            print(error)
          }
        }
      }
    }
  }
  
  func taskGroupWithCounter() async throws -> [Result<(Movie, [CrewMember], [CastMember]), Error>] {
    let movies = try await fetchMovies()
    
    let moviesWithDetails = await withThrowingTaskGroup(of: (Movie, [CrewMember], [CastMember]).self) { group in
      var results = [Result<(Movie, [CrewMember], [CastMember]), Error>]()
      var addedTasks = 0
      
      for movie in movies {
        if addedTasks >= 3 {
          print("We're at the threshold. Waiting for a task to complete.")
          if let result = await group.nextResult() {
            results.append(result)
          }
        }
        
        print("Adding a new task.")
        addedTasks += 1
        group.addTask {
          return try await fetchDetailsFor(movie)
        }
      }
      
      while let result = await group.nextResult() {
        results.append(result)
      }
      
      return results
    }
    
    return moviesWithDetails
  }
}
