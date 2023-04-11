//
//  AdvancedTaskGroupsView.swift
//  Chapter9
//
//  Created by Donny Wals on 10/04/2023.
//

import Foundation
import SwiftUI

struct AdvancedTaskGroupView: View {
  var body: some View {
    VStack(spacing: 8) {
      Button("Run task group with limit") {
        Task {
          let samples = TaskGroupSamples()
          await samples.taskGroupWithLimit()
        }
      }
      
      Button("Run task group with counter based limit") {
        Task {
          let samples = TaskGroupSamples()
          let movies = try await samples.taskGroupWithCounter()
        }
      }
    }
  }
}
