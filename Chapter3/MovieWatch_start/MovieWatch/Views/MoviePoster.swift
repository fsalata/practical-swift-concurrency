//
//  MoviePoster.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct MoviePoster: View {
  @Environment(\.movie) var movie
  
  var body: some View {
    AsyncImage(url: movie.posterURL, content: { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 80, height: 120)
        .border(Color.white, width: 4)
        .cornerRadius(8)
    }, placeholder: {
      ProgressView()
    })
    .frame(width: 80, height: 120)
  }
}
