//
//  LabelUtility.swift
//  TripPlus
//
//  Created by 유대상 on 12/29/24.
//

import Foundation
import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing * 0.5 // 줄 간격 설정 = 150%

        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.attributedText = attributedString
    }
}
