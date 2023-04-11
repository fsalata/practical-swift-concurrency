//
//  SubjectSample.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import SwiftUI
import Combine

struct SubjectSample: View {
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

extension SubjectSample {
  class ExampleRunner {
    let subject = CurrentValueSubject<Int, Never>(0)
    var example: SubjectDrivenExample?
    
    func start() {
      example = SubjectDrivenExample(subject: subject)
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
