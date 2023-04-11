//
//  SequenceSample.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI
import Combine

struct SequenceSample: View {
  let runner = ExampleRunner()
  
  var body: some View {
    VStack {
      Button("Start") {
        runner.start()
      }
      
      Button("End") {
        runner.end()
      }
      
      Button("Send Value") {
        runner.sendValue()
      }
    }
  }
}

extension SequenceSample {
  class ExampleRunner {
    let subject = CurrentValueSubject<Int, Never>(0)
    var example: SequenceDrivenExample?
    
    func start() {
      example = SequenceDrivenExample(subject: subject)
      example?.subscribe()
    }
    
    func end() {
      example = nil
    }
    
    func sendValue() {
      subject.send(Int.random(in: 0..<Int.max))
    }
  }
}
