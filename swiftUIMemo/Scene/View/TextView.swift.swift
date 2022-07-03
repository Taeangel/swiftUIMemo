//
//  TextView.swift.swift
//  swiftUIMemo
//
//  Created by song on 2022/07/03.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable { // 스위프트 유이아이에서 유아이 킷이 제공하려는 뷰를 사용하려면 임마 받아야 되요 ㅠ
  @Binding var text: String
  
  
  func makeCoordinator() -> Coordinator {
    Coordinator(uiTextView: self)
  }

  func makeUIView(context: Context) -> UITextView {
    let myTextView = UITextView()
    myTextView.delegate = context.coordinator
    
    return myTextView
  }
  
  func updateUIView(_ uiView: UITextView, context: Context) {
    uiView.text = text
  }
  
  class Coordinator: NSObject, UITextViewDelegate {
    var parent: TextView
    
    init(uiTextView: TextView) {
      self.parent = uiTextView
    }
    
    func textViewDidChange(_ textView: UITextView) {
      self.parent.text = textView.text
    }
  }
}
