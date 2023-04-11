//
//  MovieView.swift
//  MovieWatch
//
//  Created by Donny Wals on 04/07/2022.
//

import Foundation
import SwiftUI

struct MovieView: View {
  let movie: Movie
  
  var body: some View {
    ScrollView {
      VStack {
        StretchyHeaderView()
        
        VStack(alignment: .leading) {
          MoviePoster()
          
          AddToFavoritesView()
            .padding([.top, .bottom])
          
          MovieInfoView()
          
          MovieViewBottomSection()
        }
        .offset(y: -90)
        .padding()
      }
    }
    .environment(\.movie, movie)
    .coordinateSpace(name: "MovieView.ScrollView")
    .navigationTitle(movie.title)
    .navigationBarTitleDisplayMode(.inline)
  }
}




extension HorizontalAlignment {
  private enum DotAlignment : AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      return d[.leading]
    }
  }
  static let dotAlignment = HorizontalAlignment(DotAlignment.self)
}

struct MovieView_Previews: PreviewProvider {
  static var previews: some View {
    MovieView(movie: Movie.mock)
      .environmentObject(FavoritesProvider())
      .previewLayout(.sizeThatFits)
  }
}

