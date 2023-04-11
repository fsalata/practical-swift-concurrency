//
//  TaskRunner.swift
//  Chapter4
//
//  Created by Donny Wals on 02/04/2023.
//

import Foundation

class TaskRunner {
  static func run(tasks: Int) {
    for i in 0..<tasks {
      spawnTaskAndSleep(for: 3)
      print("Spawned task for \(i)")
    }
  }
  
  static func spawnTaskAndSleep(for seconds: Int) {
    Task {
      let taskId = UUID()
      print("Task \(taskId) started at \(Date())")
      sleep(UInt32(seconds))
      print("Task \(taskId) ended at \(Date())")
    }
  }
  
  static func spawnTaskAndSleep2(for seconds: Int) {
    Task {
      let taskId = UUID()
      print("Task \(taskId) started at \(Date())")
      try await Task.sleep(for: .seconds(seconds))
      print("Task \(taskId) ended at \(Date())")
    }
  }
}
