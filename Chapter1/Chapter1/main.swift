//
//  main.swift
//  Chapter1
//
//  Created by Donny Wals on 20/06/2022.
//

import Foundation

func getFullName() {
    let givenName = getGivenName()
    let familyName = getFamilyName()
    print("\(givenName) \(familyName)")
}

func getGivenName() -> String {
    print("What's your given name?")
    return readLine() ?? "--"
}

func getFamilyName() -> String {
    print("What's your family name?")
    return readLine() ?? "--"
}

getFullName()
