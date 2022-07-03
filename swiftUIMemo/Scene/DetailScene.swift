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
  
  @State private var showEditSheet = false
  @State private var showDeleteAlert = false
  
  @Environment(\.presentationMode) var presentationMode // presentationMode에 화면전환을 관리하는 객체가 저장됨
  
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
      HStack {
        Button(action: {
          showDeleteAlert.toggle()
        }, label: {
          Image(systemName: "trash")
            .foregroundColor(Color(UIColor.systemRed))
        })
        .padding()
        .alert(isPresented: $showDeleteAlert, content: {
          Alert(title: Text("삭제확인"), message: Text("메모리삭제?"),
                primaryButton: .destructive(Text("삭제"),
                  action: {
            store.delete(memo: memo)
            self.presentationMode.wrappedValue.dismiss() // 이전화면 이동
          }), secondaryButton: .cancel() )
        })
        
        Spacer() // 양쪽끝으로
        
        Button(action: {
          showEditSheet.toggle()
        }, label: {
          Image(systemName: "square.and.pencil")
        })
        .padding()
        .sheet(isPresented: $showEditSheet, content: {
          ComposeScene(showComposer: self.$showEditSheet, memo: self.memo)
            .environmentObject(store)
            .environmentObject(KeyboardObserver())
        })
      }
      .padding(.leading)
      .padding(.trailing)
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
