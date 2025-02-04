//
//  CommonMethod.swift
//  TripPlus
//
//  Created by 유대상 on 2/3/25.
//

import UIKit

extension UIViewController{
    /// Text Width + space한 CGFloat을 리턴한다.
    ///
    /**
    Cell Width를 Text의 Width + space 만큼 설정하기 위해 작성된 메소드.
    (MakingNewTripViewController, SelectCategoryViewController, SelectLocationViewController 에서 쓰임)
     */
    /// - Parameters:
    ///   - text: Width를 얻어낼 Text String
    ///   - font: text에 적용할 UIFont
    ///   - space: Cell Width에 추가적으로 적용할 Space 수치에 대한 Int값
    /// - Returns: (font가 적용된 text width + space)만큼의 CGFloat을 return
    ///
    func getTextWidth(text: String, font: UIFont, space: CGFloat) -> CGFloat{
        let text = text
        
        // 텍스트의 실제 너비 계산
        let textWidth = (text as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 30),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        ).width
        
        return textWidth + space
    }
}



/**
NavigationController의 swipe to pop이 제대로 동작하지 않아 추가되었음.
ViewController Stack의 개수가 1보다 클 때만(RootViewController가 아닐 때만) swipeback Gesture를 활성화
 */
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
