//
//  CrewList.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct CrewList: View {
  @Environment(\.movie) var movie
  
  @State var crew = [CrewMember]()
  @Environment(\.movieDataSource) var movieDataSource
  
  var body: some View {
    VStack {
      ForEach(crew, id: \.uniqueId) { crewMember in
        PersonCell(person: crewMember)
      }
    }
		.task {
			do {
				crew = try await movieDataSource.fetchCrewMembers(for: movie.id)
			} catch {
				crew = []
			}
		}
  }
}
