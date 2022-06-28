//
//  MemoStore.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import Foundation

class MemoStore: ObservableObject {
  @Published var list: [Memo]
  
  init() {
    list = [
      Memo(content: "Lorem1"),
      Memo(content: "Lorem2"),
      Memo(content: "Lorem3")
    ]
  }
  //memo CRUD
  func insert(memo: String) {
    list.insert(Memo(content: memo), at: 0)
  }
  
  func updata(memo: Memo?, content: String) {
    guard let memo = memo else {
      return
    }
    memo.content = content
  }
  
  func delete(memo: Memo) {
    list.removeAll { $0 == memo }
  }
  
  func delete(set: IndexSet) {
    for index in set {
      list.remove(at: index)
    }
  }
}
