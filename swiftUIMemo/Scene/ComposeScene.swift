//
//  ComposeScene.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import SwiftUI

struct ComposeScene: View {
  @EnvironmentObject var keyboard: KeyboardObserver
  @EnvironmentObject var store: MemoStore
  @State private var content: String = ""
  
  @Binding var showComposer: Bool
  
  var body: some View {
    NavigationView {
      VStack {
        TextView(text: $content)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      //    .padding(.bottom, keyboard.context.height) //왜 이렇까 ㅠ
          .animation(.easeInOut(duration: keyboard.context.animationDuration))
//          .background(Color.yellow)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle("새 메모")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(
        leading: DismissButton(show: $showComposer),
        trailing: SaveButton(show: $showComposer, content: $content))
    }
  }
}

fileprivate struct DismissButton: View {
  @Binding var show: Bool
  
  var body: some View {
    Button(action: {
      show = false
    }, label: {
      Text("취소")
    })
  }
}

fileprivate struct SaveButton: View {
  @Binding var show: Bool

  @EnvironmentObject var store: MemoStore
  @Binding var content: String
  
  var body: some View {
    Button(action: {
      store.insert(memo: content)
      show = false
    }, label: {
      Text("저장")
    })
  }
}

struct ComposeScene_Previews: PreviewProvider {
  static var previews: some View {
    ComposeScene(showComposer: .constant(false)) 
      .environmentObject(MemoStore())
      .environmentObject(KeyboardObserver())
  }
}
