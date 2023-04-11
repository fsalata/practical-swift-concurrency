//
//  PersonCell.swift
//  MovieWatch
//
//  Created by Donny Wals on 05/07/2022.
//

import Foundation
import SwiftUI

struct PersonCell: View {
  let person: Person
  
  var body: some View {
    HStack {
      AsyncImage(url: person.profileURL, content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 60, height: 60)
          .border(Color.white, width: 4)
          .cornerRadius(8)
      }, placeholder: {
        Rectangle()
          .fill(Color.gray)
          .cornerRadius(8)
          .frame(width: 60, height: 60)
      })
      .frame(width: 60, height: 60)
      
      
      VStack(alignment: .leading) {
        Text(person.name)
          .font(.headline)
        Text(person.role)
      }
      
      Spacer()
    }
  }
}
