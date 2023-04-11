//
//  CastList.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct CastList: View {
  @Environment(\.movie) var movie
  
  @State var cast = [CastMember]()
  @Environment(\.movieDataSource) var movieDataSource
  
  var body: some View {
    let _ = Self._printChanges
    
    VStack {
      ForEach(cast, id: \.uniqueId) { castMember in
        PersonCell(person: castMember)
      }
		}
		.task {
			do {
				cast = try await movieDataSource.fetchCastMembers(for: movie.id)
			} catch {
				cast = []
			}
		}
  }
}
