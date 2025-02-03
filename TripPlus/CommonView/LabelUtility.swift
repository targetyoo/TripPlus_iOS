//
//  LabelUtility.swift
//  TripPlus
//
//  Created by 유대상 on 12/29/24.
//

import Foundation
import UIKit

extension UILabel {
    /// Text의 줄 간격을 설정한다(150% 고정).
    ///
    /**
    Trip+ 디자인에 의한 줄간격 구현을 위해 생성한 UILabel extension 메소드.
     */
    /// - Parameters:
    ///   - lineHeight: label에 적용된 font에 대한 Line height
    /// - Returns: void
    ///
    func setLineSpacing(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight * 0.5 // 줄 간격 설정 = 150%

        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
