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
  
  var memo: Memo? = nil // 메모가 전달되면 편집모드 전달되지 않으면 쓰기모드
  
  var body: some View  {
    NavigationView {
      VStack {
        TextView(text: $content)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      //    .padding(.bottom, keyboard.context.height) //왜 이렇까 ㅠ
          .animation(.easeInOut(duration: keyboard.context.animationDuration))
//          .background(Color.yellow)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationTitle(memo != nil ? "메모 편집" : "새 메모")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(
        leading: DismissButton(show: $showComposer),
        trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
    }
    .onAppear {
     //화면이 표시되는 시점에 초기화를 구현하고 싶으면 여기서 구현
      self.content = self.memo?.content ?? ""
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
  
  var memo: Memo? = nil
  
  var body: some View {
    Button(action: {
      
      if let memo = self.memo {
        store.updata(memo: memo, content: content)
      } else {
        store.insert(memo: content)
      }
      
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
