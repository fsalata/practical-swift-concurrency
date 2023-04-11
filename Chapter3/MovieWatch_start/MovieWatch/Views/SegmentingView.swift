//
//  SegmentingView.swift
//  MovieWatch
//
//  Created by Donny Wals on 07/07/2022.
//

import Foundation
import SwiftUI

struct SegmentingView: View {
  let strings: [String]
  @Binding var selectedText: String
  @State var selectedTextWidth: CGFloat = 20
  
  var body: some View {
    VStack(alignment: .dotAlignment) {
      buttonBar
        .padding([.leading, .trailing])
      
      selectionIndicator
    }.tint(Color.red)
  }
  
  var buttonBar: some View {
    HStack(spacing: 12) {
      Spacer()
      ForEach(strings, id: \.self) { text in
        makeButton(text)
      }
      Spacer()
    }
  }
  
  var selectionIndicator: some View {
    Rectangle()
      .fill(.red)
      .frame(width: selectedTextWidth, height: 4)
      .alignmentGuide(.dotAlignment, computeValue: { d in d[HorizontalAlignment.center] })
  }
  
  func makeButton(_ text: String) -> some View {
    Button(action: {
      withAnimation {
        selectedText = text
      }
    }, label: {
      if text == selectedText {
        Text("\(text)")
          .background(LabelMeasurer())
          .onPreferenceChange(LabelMeasurer.SizePreferenceKey.self, perform: { size in
            withAnimation {
              selectedTextWidth = size.width
            }
          })
          .alignmentGuide(.dotAlignment, computeValue: { d in d[HorizontalAlignment.center] })
      } else {
        Text(text)
      }
    })
  }
}
