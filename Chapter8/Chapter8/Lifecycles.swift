//
//  Lifecycles.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import Combine

class Lifecycles {
  var cancellable: AnyCancellable?
  
  func nonStoredCancellable() {
    let cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://practicalswiftconcurrency.com")!)
      .sink(receiveCompletion: { _ in
        print("received completion")
      }, receiveValue: { _ in
        print("received response")
      })
  }

  func storedCancellable() {
      cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://practicalswiftconcurrency.com")!)
          .sink(receiveCompletion: { _ in
              print("received completion")
          }, receiveValue: { _ in
              print("received response")
          })
  }
}

class SubjectDrivenExample {
  let subject: CurrentValueSubject<Int, Never>
  var cancellable: AnyCancellable?
  
  init(subject: CurrentValueSubject<Int, Never>) {
    self.subject = subject
  }
  
  deinit {
    print("subject driven example deinit")
  }
  
  func subscribe() {
    cancellable = subject.sink(receiveValue: { value in
      print("received \(value)")
    })
  }
}

class SequenceDrivenExample {
  let subject: CurrentValueSubject<Int, Never>
  var task: Task<Void, Never>?
  
  init(subject: CurrentValueSubject<Int, Never>) {
    self.subject = subject
  }
  
  deinit {
    print("sequence driven example deinit")
    task?.cancel()
  }
  
  func subscribe() {
    Task { [weak self] in
      guard let self else {
        return
      }
      for await value in self.subject.values {
        print("received \(value)")
      }
    }
  }
  
  func fixedSubscribe() {
    Task { [subject] in
      for await value in subject.values {
        print("received \(value)")
      }
    }
  }
  
  func actuallyFixedSubscribe() {
    task = Task { [subject] in
      for await value in subject.values {
        print("received \(value)")
      }
    }
  }
}

extension Task {
  func store(in cancellables: inout Set<AnyCancellable>) {
    cancellables.insert(AnyCancellable {
      self.cancel()
    })
  }
}
