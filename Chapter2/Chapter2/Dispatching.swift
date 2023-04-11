//
//  Dispatching.swift
//  Chapter2
//
//  Created by Donny Wals on 31/03/2023.
//

import Foundation

func performSync() {
  print("sync: before")
  DispatchQueue.global().sync {
    print("sync: inside")
  }
  print("sync: after")
}

func performAsync() {
  print("async: before")
  DispatchQueue.global().async {
    print("async: inside")
  }
  print("async: after")
}
