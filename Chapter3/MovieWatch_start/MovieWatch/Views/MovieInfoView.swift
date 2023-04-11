//
//  MovieInfoView.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct MovieInfoView: View {
  @Environment(\.movie) var movie
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(movie.title)
        .font(.title)
        .bold()
        .lineLimit(nil)
        .fixedSize(horizontal: false, vertical: true)
      
      VStack(alignment: .leading, spacing: 4) {
        HStack (alignment: .lastTextBaseline) {
          Text("🗓").font(.title)
          Text("Release:").font(.headline)
          Text(movie.releaseDate)
          Spacer()
        }
        
        HStack(alignment: .lastTextBaseline, spacing: 4) {
          Text("🤩").font(.title)
            .alignmentGuide(.lastTextBaseline, computeValue: { d in
              d[.lastTextBaseline] - d.height * 0.05
            })
          Text("Popularity:").font(.headline)
          Text("\(movie.popularity, specifier: "%.2f")")
          Spacer()
        }
        
        HStack(alignment: .lastTextBaseline, spacing: 4) {
          Text("🎟").font(.title)
            .alignmentGuide(.lastTextBaseline, computeValue: { d in
              d[.lastTextBaseline] - d.height * 0.1
            })
          Text("Rating").font(.headline)
          Text("\(movie.voteAverage, specifier: "%.2f")").font(.title)
            .alignmentGuide(.lastTextBaseline, computeValue: { d in
              d[.lastTextBaseline] - d.height * 0.05
            })
          Text("(\(movie.voteCount) votes)").font(.caption)
        }
      }
    }
  }
}

