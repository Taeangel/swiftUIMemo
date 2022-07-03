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
  
  @State var showComposer: Bool = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.list) { memo in
          NavigationLink(destination: DetailScene(memo: memo), label: {
            MemoCell(memo: memo)
          })
          
        }//onDelete 위치가 중요함
        .onDelete(perform: store.delete)
      }
      .navigationTitle("내 메모")
      .navigationBarItems(trailing: ModalButton(show: $showComposer)) //값이 전달되는것이 아니라 바인딩을 전달
      .sheet(isPresented: $showComposer, content: {
        ComposeScene(showComposer: self.$showComposer)
        //          .environmentObject(store)//????? 안해줘도 되는데??
          .environmentObject(KeyboardObserver())
      })
      
    }
  }
}

fileprivate struct ModalButton: View {
  @Binding var show: Bool//다른곳에잇는 속성을 바꾸는
  
  var body: some View {
    Button(action: {
      show = true// 이러면 showComposer의 속성을 바꿈
    }, label: {
      Image(systemName: "plus")
    })
  }
}

struct MemoListScene_Previews: PreviewProvider {
  static var previews: some View {
    MemoListScene()
      .environmentObject(MemoStore())
      .environmentObject(DateFormatter.memoDateFormatter)
  }
}
