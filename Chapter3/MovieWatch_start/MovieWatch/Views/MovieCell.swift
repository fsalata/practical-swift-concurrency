//
//  MovieCell.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/07/2022.
//

import Foundation
import SwiftUI

struct MovieCell: View {
  @ObservedObject var movieViewModel: MovieViewModel
  
  var isFavorite: Bool {
    movieViewModel.isFavorite
  }
  
  var movie: Movie {
    movieViewModel.movie
  }
  
  var body: some View {
    HStack(alignment: .top) {
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
      
      VStack(alignment: .leading, spacing: 4) {
        Text(movie.title)
          .font(.title2).bold()
        
        Text(movie.releaseDate)
          .font(.callout)
        
        HStack(alignment: .lastTextBaseline) {
          HStack(alignment: .lastTextBaseline, spacing: 2) {
            Text("🤩")
              .font(.title2)
              .alignmentGuide(.lastTextBaseline, computeValue: { d in d[.lastTextBaseline] - d.height * 0.01 })
            Text("\(movie.popularity, specifier: "%.2f")")
              .font(.caption)
          }
          
          HStack(alignment: .lastTextBaseline, spacing: 2) {
            Text("🎟")
              .font(.title2)
              .alignmentGuide(.lastTextBaseline, computeValue: { d in d[.lastTextBaseline] - d.height * 0.1 })
            Text("\(movie.voteAverage, specifier: "%.2f")")
              .font(.caption)
          }
        }
      }
      
      Spacer()
      
      Image(systemName: isFavorite ? "star.fill" : "star")
    }
  }
}

struct MovieCell_Previews: PreviewProvider {
  static var previews: some View {
    MovieCell(movieViewModel: .init(movie: .mock, favoritesProvider: .init()))
      .previewLayout(.sizeThatFits)
  }
}
