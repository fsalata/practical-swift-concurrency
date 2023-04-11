//
//  TaskGroupView.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation
import SwiftUI

struct TaskGroupView: View {
  var body: some View {
    VStack(spacing: 8) {
      Button("Run serial") {
        Task {
          let samples = TaskGroupSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchEnrichedMovies_serial()
          print("Serial call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run with Task Group") {
        Task {
          let samples = TaskGroupSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchEnrichedMovies_taskgroup1()
          print("Serial call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run random Int example") {
        Task {
          let samples = TaskGroupSamples()
          let start = CACurrentMediaTime()
          let _ = await samples.taskGroupWithIntReturnType()
          print("Random Int example call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run unhandled errors example") {
        Task {
          let samples = TaskGroupSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchEnrichedMovies_unhandledErrors()
          print("Unhandled errors example call took \(CACurrentMediaTime() - start) seconds")
        }
      }
      
      Button("Run Task Group with Result") {
        Task {
          let samples = TaskGroupSamples()
          let start = CACurrentMediaTime()
          let _ = try await samples.fetchEnrichedMovies_usingResult()
          print("Result example call took \(CACurrentMediaTime() - start) seconds")
        }
      }
    }
  }
}
