//
//  Memo.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import SwiftUI

class Memo: Identifiable, ObservableObject {
  //Identifiable 채택하면 데이터 목록을 테이블 뷰나 컬랙션 뷰에 쉽게 바인딩가능
  //observableObject 채택하면 반응형 UI를 구현하기위해 필요함
  
  let id: UUID
  @Published var content: String //Published를 선언하면 새로운 값이 저장될때마다 바인딩되어있는 UI가 자동으로 업데이트 됩니다.
  let insertData: Date //메모생성날짜 저장
  
  init(id: UUID = UUID() ,content: String, insertData: Date = Date()) {
    self.id = id
    self.content = content
    self.insertData = insertData
  }
}

extension Memo: Equatable {
  static func == (lhs: Memo, rhs: Memo) -> Bool {
    return lhs.id == rhs.id 
  }
}
