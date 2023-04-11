//
//  Caches.swift
//  Chapter2
//
//  Created by Donny Wals on 31/03/2023.
//

import Foundation

class SimpleCache<Key: Hashable, T> {
    private var cache: [Key: T] = [:]
    private let queue = DispatchQueue(label: "SimpleCache.\(UUID().uuidString)")
    
    func getValue(forKey key: Key) -> T? {
        return queue.sync {
            return cache[key]
        }
    }
    
    func setValue(_ value: T, forKey key: Key) {
        queue.sync {
            cache[key] = value
        }
    }
}

class SimpleCache2<Key: Hashable, T> {
  private var cache: [Key: T] = [:]
  private let semaphore = DispatchSemaphore(value: 1)

  func getValue(forKey key: Key) -> T? {
    semaphore.wait()
    let value = cache[key]
    semaphore.signal()
    return value
  }
    
  func setValue(_ value: T, forKey key: Key) {
    semaphore.wait()
    cache[key] = value
    semaphore.signal()
  }
}

class SimpleCache3<Key: Hashable, T> {
  private var cache: [Key: T] = [:]
  private let lock = NSLock()
    
  func getValue(forKey key: Key) -> T? {
    lock.lock()
    let value = cache[key]
    lock.unlock()
    return value
  }
    
  func setValue(_ value: T, forKey key: Key) {
    lock.lock()
    cache[key] = value
    lock.unlock()
  }
}
