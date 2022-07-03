//
//  DetailScene.swift
//  swiftUIMemo
//
//  Created by song on 2022/07/04.
//

import SwiftUI

struct DetailScene: View {
  @ObservedObject var memo: Memo
  
  @EnvironmentObject var store: MemoStore
  @EnvironmentObject var formatter: DateFormatter
  
  var body: some View {
    VStack {
      ScrollView {
        VStack {
          HStack {
            Text(self.memo.content)
              .padding()
            Spacer()
          }
          
          Text("\(self.memo.insertData, formatter: formatter)")
            .padding()
            .font(.footnote)
            .foregroundColor(.secondary)
        }
      }
    }
    .navigationTitle("메모보기")
  }
}

struct DetailScene_swift_Previews: PreviewProvider {
  static var previews: some View {
    DetailScene(memo: Memo(content: "SwiftUI"))
      .environmentObject(MemoStore())
      .environmentObject(DateFormatter.memoDateFormatter)
  }
}
