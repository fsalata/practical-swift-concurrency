//
//  CSVReader.swift
//  Chapter7
//
//  Created by Donny Wals on 06/04/2023.
//

import Foundation

struct CSVReader {
  static func runSynchronous() {
    var cars = [Car]()
    // Make sure your local server is running. See local-servers in this chapter's folder.
    let url = URL(string: "http://127.0.0.1:8080/cars.csv")!
    do {
      let csvData = try Data(contentsOf: url)
      let csvString = String(data: csvData, encoding: .utf8)
      let csvLines = csvString?.components(separatedBy: "\n") ?? []
      for line in csvLines {
        let components = line.components(separatedBy: ",")
        guard components.count == 4 else {
          continue
        }
        let car = Car(year: components[0],
                      make: components[1],
                      model: components[2],
                      body_styles: components[3])
        cars.append(car)
      }

      print(cars)
    }
    catch {
      print("Could not load csv file")
      print(error)
    }
  }
  
  static func runAsyncLoop() async {
    var cars = [Car]()
    // Make sure your local server is running. See local-servers in this chapter's folder.
    let csvURL = URL(string: "http://127.0.0.1:8080/cars.csv")!
    
    do {
      for try await line in csvURL.lines {
        let components = line.components(separatedBy: ",")
        guard components.count == 4 else {
          continue
        }
        let car = Car(year: components[0],
                      make: components[1],
                      model: components[2],
                      body_styles: components[3])
        cars.append(car)
      }

      print(cars)
    }
    catch {
      print("Could not load csv file")
      print(error)
    }
  }
  
  static func asyncLoopWithMap() async {
    var cars = [Car]()
    // Make sure your local server is running. See local-servers in this chapter's folder.
    let csvURL = URL(string: "http://127.0.0.1:8080/cars.csv")!
    
    do {
      let sequence = csvURL.lines
        .map { line in
          let components = line.components(separatedBy: ",")
          guard components.count == 4 else {
            return Car(year: "", make: "", model: "", body_styles: "")
          }
          let car = Car(year: components[0],
                        make: components[1],
                        model: components[2],
                        body_styles: components[3])
          return car
        }

      for try await car in sequence {
        cars.append(car)
      }

      print(cars)
    }
    catch {
      print("Could not load csv file")
      print(error)
    }
  }
}
