//
//  LocationProvider.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Combine
import CoreLocation

// Initial version of location provider
class LocationProvider1: NSObject {
  fileprivate let locationManager = CLLocationManager()
  fileprivate var continuation: AsyncStream<CLLocation>.Continuation?
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestPermissionIfNeeded() {
    if locationManager.authorizationStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func startUpdatingLocation() -> AsyncStream<CLLocation> {
    requestPermissionIfNeeded()
    
    locationManager.startUpdatingLocation()
    
    return AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
      self.continuation = continuation
    }
  }
}

extension LocationProvider1: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for location in locations {
      continuation?.yield(location)
    }
  }
}

// Version of location provider that reuses its stream
actor LocationProvider2: NSObject {
  fileprivate let locationManager = CLLocationManager()
  fileprivate var continuation: AsyncStream<CLLocation>.Continuation?
  private var stream: AsyncStream<CLLocation>?
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestPermissionIfNeeded() {
    if locationManager.authorizationStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func startUpdatingLocation() -> AsyncStream<CLLocation> {
    if let stream {
      return stream
    }
    
    requestPermissionIfNeeded()
    
    locationManager.startUpdatingLocation()
    
    stream = AsyncStream(bufferingPolicy: .bufferingNewest(1)) { continuation in
      self.continuation = continuation
    }
    
    return stream!
  }
}

extension LocationProvider2: CLLocationManagerDelegate {
  nonisolated func locationManager(_ manager: CLLocationManager,
                                   didUpdateLocations locations: [CLLocation]) {
    Task {
      for location in locations {
        await continuation?.yield(location)
      }
    }
  }
}
