//
//  StretchyHeaderView.swift
//  MovieWatch
//
//  Created by Donny Wals on 05/07/2022.
//

import Foundation
import SwiftUI

struct StretchyHeaderView: View {
  @Environment(\.movie) var movie
  
  func headerHeight(using proxy: GeometryProxy) -> CGFloat {
    return proxy.frame(in: .named("MovieView.ScrollView")).minY > 0
    ? 300 + proxy.frame(in: .named("MovieView.ScrollView")).minY
    : 300
  }
  
  var body: some View {
    GeometryReader { proxy in
      AsyncImage(url: movie.backdropURL,
                 content: { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(height: headerHeight(using: proxy))
        
      }, placeholder: {
        ProgressView()
      })
      .frame(width: proxy.size.width, height: headerHeight(using: proxy))
      .offset(y: proxy.frame(in: .named("MovieView.ScrollView")).minY > 0 ? -proxy.frame(in: .named("MovieView.ScrollView")).minY : 0)
    }.frame(height: 300)
  }
}

