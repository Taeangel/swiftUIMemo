//
//  KeyboardObserved.swift.swift
//  swiftUIMemo
//
//  Created by song on 2022/07/03.
//

import UIKit
import Combine

class KeyboardObserver: ObservableObject {
  struct Context {
    let animationDuration: TimeInterval
    let height: CGFloat
    
    static let hide = Self(animationDuration: 0.25, height: 0)
  }
  
  @Published var context = Context.hide//값이 업데이트되면 연관된 데이터가 자동으로 업데이트되도록
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
    let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)
    
    willShow.merge(with: willHide)
      .compactMap(parse)
      .assign(to: \.context, on: self)
      .store(in: &cancellables)
  }
  
  func parse(notification: Notification) -> Context? {
    guard let userInfo = notification.userInfo else {
      return nil
    }
    
    let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
    let anmationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    var height: CGFloat = 0
    
    if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      
      let frame = value.cgRectValue
      
      if frame.origin.y < UIScreen.main.bounds.height {
        height = frame.height - (safeAreaInsets?.bottom ?? 0)
      }
    }
    return Context(animationDuration: anmationDuration, height: height)
  }
  
}
