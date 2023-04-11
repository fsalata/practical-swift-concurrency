//
//  MovieViewBottomSection.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct MovieViewBottomSection: View {
  @Environment(\.movie) var movie
  @State var selectedText: String = "Summary"
  let strings = ["Summary", "Cast", "Crew"]
  
  var body: some View {
    VStack {
      SegmentingView(strings: strings, selectedText: $selectedText)
      
      switch selectedText {
      case "Crew":
        CrewList()
      case "Cast":
        CastList()
      default:
        Text(movie.overview)
          .lineLimit(nil)
          .fixedSize(horizontal: false, vertical: true)
      }
    }
  }
}
