//
//  LocationProvider.swift
//  Chapter8
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation
import CoreLocation
import Combine

class LocationProvider: NSObject {
  fileprivate let locationManager = CLLocationManager()
  fileprivate var subject = CurrentValueSubject<CLLocation?, Never>(nil)
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestPermissionIfNeeded() {
    if locationManager.authorizationStatus == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  func startUpdatingLocation() -> AsyncPublisher<AnyPublisher<CLLocation, Never>> {
    requestPermissionIfNeeded()
    
    locationManager.startUpdatingLocation()
    
    return subject
      .compactMap({ $0 })
      .eraseToAnyPublisher()
      .values
  }
}

extension LocationProvider: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    for location in locations {
      subject.send(location)
    }
  }
}

