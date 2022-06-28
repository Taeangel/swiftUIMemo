//
//  DateFormatter+Memo.swift
//  swiftUIMemo
//
//  Created by song on 2022/06/29.
//

import Foundation

extension DateFormatter {
  static let memoDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "Ko_kr")
    return dateFormatter
  }()
}


extension DateFormatter: ObservableObject {
  
}
