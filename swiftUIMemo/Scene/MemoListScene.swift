//
//  ContentView.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import SwiftUI

struct MemoListScene: View {
  @EnvironmentObject var store: MemoStore // 하나의 데이터를 여러군데서 공유함
  @EnvironmentObject var formatter: DateFormatter
  
  var body: some View {
    NavigationView {
      List(store.list) { memo in
        MemoCell(memo: memo)
      }
      .navigationTitle("내 메모")
    }
  }
}

struct MemoListScene_Previews: PreviewProvider {
  static var previews: some View {
    MemoListScene()
      .environmentObject(MemoStore())
      .environmentObject(DateFormatter.memoDateFormatter)
  }
}
