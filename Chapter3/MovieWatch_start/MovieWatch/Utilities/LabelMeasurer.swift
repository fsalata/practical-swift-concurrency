//
//  LabelMeasurer.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct LabelMeasurer: View {
  var body: some View {
    GeometryReader { geometry in
      Color.clear
        .preference(key: SizePreferenceKey.self, value: geometry.size)
    }
  }
}

extension LabelMeasurer {
  struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
      value = nextValue()
    }
  }
}
